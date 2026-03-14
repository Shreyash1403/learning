import 'package:dio/dio.dart';
import 'package:learning_2/core/api/exceptions.dart';

// ======================================================================
// HOW PROPER REST APIs WORK (Google, Twitter, Razorpay, etc.)
// ======================================================================
//
// These APIs use ACTUAL HTTP status codes:
//
// ┌──────────┬────────────────────────────────────────────────────────┐
// │ HTTP Code│ What it means                                         │
// ├──────────┼────────────────────────────────────────────────────────┤
// │ 200      │ ✅ Success — data is here                             │
// │ 201      │ ✅ Created — new resource created successfully        │
// │ 204      │ ✅ No Content — success but nothing to return         │
// │ 400      │ ❌ Bad Request — you sent wrong/missing parameters    │
// │ 401      │ ❌ Unauthorized — invalid token / not logged in       │
// │ 403      │ ❌ Forbidden — logged in but no permission            │
// │ 404      │ ❌ Not Found — URL or resource doesn't exist          │
// │ 422      │ ❌ Validation Error — data format is wrong            │
// │ 429      │ ❌ Too Many Requests — rate limited (too fast)        │
// │ 500      │ ❌ Server Error — server crashed                      │
// │ 502      │ ❌ Bad Gateway — server is down                       │
// │ 503      │ ❌ Service Unavailable — server overloaded            │
// └──────────┴────────────────────────────────────────────────────────┘
//
// DIFFERENCE FROM YOUR API:
//
// ┌────────────────────────────────────────────────────────────────────┐
// │ YOUR API (Indian backend style):                                  │
// │   HTTP 200 + error_code: 100 → Success                           │
// │   HTTP 200 + error_code: 302 → Error (same HTTP status!)         │
// │   HTTP 200 + error_code: 440 → Session expired                   │
// │   → Must check INSIDE the body                                    │
// ├────────────────────────────────────────────────────────────────────┤
// │ PROPER REST API (Google/Twitter style):                           │
// │   HTTP 200 → Success (data in body)                               │
// │   HTTP 401 → Unauthorized (error in body)                         │
// │   HTTP 404 → Not Found (error in body)                            │
// │   → HTTP status code ITSELF tells you what happened               │
// └────────────────────────────────────────────────────────────────────┘
// ======================================================================

// ======================================================================
// SAMPLE: A Weather App using OpenWeatherMap API
// ======================================================================
//
// API Examples:
//
// ✅ HTTP 200 — Success:
// {
//   "weather": [{"main": "Clouds", "description": "overcast clouds"}],
//   "main": {"temp": 28.5, "humidity": 65},
//   "name": "Mumbai"
// }
//
// ❌ HTTP 400 — Bad Request:
// { "cod": 400, "message": "Nothing to geocode" }
//
// ❌ HTTP 401 — Unauthorized:
// { "cod": 401, "message": "Invalid API key" }
//
// ❌ HTTP 404 — Not Found:
// { "cod": "404", "message": "city not found" }
//
// ❌ HTTP 500 — Server Error:
// (server crashed, may not even return JSON)
// ======================================================================

// ============= SAMPLE MODEL =============
class WeatherData {
  final String cityName;
  final double temperature;
  final int humidity;
  final String description;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.humidity,
    required this.description,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name']?.toString() ?? '',
      temperature: (json['main']?['temp'] as num?)?.toDouble() ?? 0.0,
      humidity: json['main']?['humidity'] ?? 0,
      description:
          (json['weather'] as List?)?.first?['description']?.toString() ?? '',
    );
  }
}

// ============= SERVICE WITH PROPER HTTP STATUS CODES =============
class WeatherService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.openweathermap.org/data/2.5',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      // IMPORTANT: By default Dio throws error on non-200 status codes.
      // We set validateStatus to accept ALL status codes so WE can handle them.
      validateStatus: (status) =>
          true, // Accept all HTTP codes (don't auto-throw)
    ),
  );

  Future<WeatherData> getWeather(String city) async {
    try {
      // ================================================================
      // STEP 1: MAKE THE API CALL
      // ================================================================
      final Response response = await _dio.get(
        '/weather',
        queryParameters: {
          'q': city,
          'appid': 'YOUR_API_KEY',
          'units': 'metric',
        },
      );

      // ================================================================
      // STEP 2: CHECK HTTP STATUS CODE
      // ================================================================
      //
      // HERE is the big difference from your API!
      // The HTTP status code ITSELF tells us what happened.
      // No need to check inside the body for "error_code".
      //
      // ┌──────────────────────────────────────────────────────────┐
      // │ Your API:    if (data['error_code'] == 100) → success   │
      // │ Proper API:  if (statusCode == 200) → success           │
      // └──────────────────────────────────────────────────────────┘

      switch (response.statusCode) {
        // ============= SUCCESS CODES (2xx) =============
        case 200:
          // ✅ Success — parse and return data
          return WeatherData.fromJson(response.data);

        // ============= CLIENT ERROR CODES (4xx) =============
        case 400:
          // ❌ Bad Request — wrong parameters
          // Body: { "message": "Nothing to geocode" }
          final msg = response.data?['message'] ?? 'Bad request';
          throw ApiException(errorCode: 400, message: msg);

        case 401:
          // ❌ Unauthorized — invalid API key / session expired
          // This is like YOUR error_code 440!
          throw SessionExpiredException(
            message: response.data?['message'] ?? 'Unauthorized',
          );

        case 403:
          // ❌ Forbidden — no permission
          throw ApiException(
            errorCode: 403,
            message: response.data?['message'] ?? 'Access denied',
          );

        case 404:
          // ❌ Not Found — city doesn't exist
          // Body: { "message": "city not found" }
          throw ApiException(
            errorCode: 404,
            message: response.data?['message'] ?? 'Not found',
          );

        case 429:
          // ❌ Too Many Requests — rate limited
          throw ApiException(
            errorCode: 429,
            message: 'Too many requests. Please wait and try again.',
          );

        // ============= SERVER ERROR CODES (5xx) =============
        case 500:
        case 502:
        case 503:
          // ❌ Server crashed / down / overloaded
          throw ApiException(
            errorCode: response.statusCode ?? 500,
            message: 'Server error. Please try again later.',
          );

        // ============= ANY OTHER CODE =============
        default:
          throw ApiException(
            errorCode: response.statusCode ?? 0,
            message: response.data?['message'] ?? 'Unknown error',
          );
      }

      // ================================================================
      // CATCH BLOCKS — Same hierarchy as your service!
      // ================================================================
    } on DioException catch (e) {
      // ---- NETWORK ERROR (no internet, timeout) ----
      // Same as your service — request didn't reach server
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          throw NetworkException(
            message: 'Connection timed out. Please try again.',
          );
        case DioExceptionType.connectionError:
          throw NetworkException(message: 'No internet connection.');
        default:
          throw NetworkException(message: 'Network error. Please try again.');
      }
    } on SessionExpiredException {
      rethrow;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(errorCode: 0, message: 'Something went wrong: $e');
    }
  }
}

// ======================================================================
// COMPARISON: YOUR API vs PROPER REST API
// ======================================================================
//
// ┌─────────────────────────────────────────────────────────────────┐
// │                    YOUR API                                     │
// │                                                                 │
// │  HTTP always 200                                                │
// │       │                                                         │
// │       ▼                                                         │
// │  Read error_code from body                                      │
// │       │                                                         │
// │       ├── 100 → success                                         │
// │       ├── 440 → session expired                                 │
// │       └── other → error                                         │
// │                                                                 │
// │  Service uses: switch (data['error_code'])                      │
// ├─────────────────────────────────────────────────────────────────┤
// │                   PROPER REST API                               │
// │                                                                 │
// │  HTTP status code varies (200, 400, 401, 404, 500)              │
// │       │                                                         │
// │       ▼                                                         │
// │  Read HTTP status code directly                                 │
// │       │                                                         │
// │       ├── 200 → success                                         │
// │       ├── 401 → session expired                                 │
// │       └── other → error                                         │
// │                                                                 │
// │  Service uses: switch (response.statusCode)                     │
// └─────────────────────────────────────────────────────────────────┘
//
// WHAT'S THE SAME IN BOTH:
// ✅ try-catch hierarchy (DioException → specific → generic)
// ✅ Custom exception classes (ApiException, SessionExpired, Network)
// ✅ Switch statement to handle different codes
// ✅ Service returns model or throws exception
//
// WHAT'S DIFFERENT:
// 🔄 Where the status code comes from:
//    Your API:   response.data['error_code']
//    Proper API: response.statusCode
//
// That's the ONLY difference! The pattern is the same! 🎯
// ======================================================================
