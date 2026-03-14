import 'package:dio/dio.dart';
import 'package:learning_2/core/api/api_client.dart';
import 'package:learning_2/core/api/exceptions.dart';
import 'package:learning_2/modules/livelink/models/livelink_model.dart';

// ======================================================================
// LIVELINK SERVICE
// ======================================================================
//
// ROLE: Makes API call → checks error_code → returns model or throws
//
// FLOW:
// UI → BLoC → Repository → [THIS SERVICE] → API Server
//
// This service ONLY does:
// 1. Make the HTTP request
// 2. Check error_code inside response
// 3. Return parsed model (if success) or throw exception (if error)
//
// It does NOT:
// - Decide what to show in UI (BLoC's job)
// - Navigate to login screen (UI's job)
// - Add business logic (Repository's job)
// ======================================================================

class LiveLinkService {
  final Dio _dio = ApiClient.dio;

  // ============= API ENDPOINT =============
  // This API uses a different base URL pattern than complaints
  // Full URL: https://vocoxp.staffhandler.com/vocoxp/api/livelink_user_list_ver_1.2.php
  static const String _endpoint = '/vocoxp/api/livelink_user_list_ver_1.2.php';

  // ============= FETCH LIVELINK USERS =============
  /// Fetches livelink user list from API
  ///
  /// Parameters explained:
  /// - locationId: Which location to fetch users for (e.g., "LOC-00005")
  /// - verificationOf: Type of verification (1, 4, 5, etc.)
  /// - fromDate: Start date filter (format: "07-05-2025")
  /// - toDate: End date filter (format: "17-02-2026")
  /// - page: Pagination page number (1, 2, 3...)
  /// - statusType: Filter by status ("All", "Active", "Completed", etc.)
  /// - limit: Number of records per page (10, 20, etc.)
  ///
  /// Returns: LiveLinkResponseModel on success
  /// Throws: ApiException, SessionExpiredException, or NetworkException
  Future<LiveLinkResponseModel> fetchLiveLinkUsers({
    required String locationId,
    required int verificationOf,
    required String fromDate,
    required String toDate,
    required int page,
    String statusType = 'All',
    int limit = 10,
  }) async {
    try {
      // ================================================================
      // STEP 1: MAKE THE API CALL
      // ================================================================
      // _dio.get() accepts 'queryParameters' which are added to the URL
      //
      // This: _dio.get('/api/users', queryParameters: {'page': 1, 'limit': 10})
      // Becomes: /api/users?page=1&limit=10
      //
      // Much cleaner than manually building the URL string!
      final Response response = await _dio.get(
        _endpoint,
        queryParameters: {
          'location_id': locationId,
          'verification_of': verificationOf,
          'from_date': fromDate,
          'to_date': toDate,
          'page': page,
          'status_type': statusType,
          'limit': limit,
        },
      );

      // ================================================================
      // STEP 2: CHECK IF RESPONSE EXISTS
      // ================================================================
      if (response.data == null) {
        throw ApiException(errorCode: 0, message: 'Empty response from server');
      }

      // ================================================================
      // STEP 3: READ THE error_code FROM RESPONSE BODY
      // ================================================================
      //
      // Remember: HTTP status is ALWAYS 200
      // The REAL status is "error_code" inside the JSON body
      //
      // ✅ { "error_code": 100, "message": "Success", ... }
      // ❌ { "error_code": 302, "message": "Agency inactive" }
      // ❌ { "error_code": 440, "message": "Session expired" }
      //
      final Map<String, dynamic> data = response.data;
      final int errorCode = data['error_code'] ?? 0;
      final String message = data['message'] ?? 'Unknown error';
      final String responseCode = data['response_code'] ?? '';

      // ================================================================
      // STEP 4: HANDLE EACH error_code
      // ================================================================
      //
      // error_code 100 → ✅ Success → Parse and return data
      // error_code 440 → ⛔ Session expired → throw SessionExpiredException
      // everything else → ❌ Error → throw ApiException
      //
      switch (errorCode) {
        case 100:
          // ✅ SUCCESS — Parse JSON into model and return
          return LiveLinkResponseModel.fromJson(data);

        case 440:
          // ⛔ SESSION EXPIRED — Throw special exception
          // BLoC will catch this and tell UI to go to login screen
          throw SessionExpiredException(message: message);

        default:
          // ❌ ANY OTHER ERROR (105, 302, 310, etc.)
          // Throw ApiException with the error details
          // BLoC will catch this and show the message to user
          throw ApiException(
            errorCode: errorCode,
            message: message,
            responseCode: responseCode,
          );
      }

      // ================================================================
      // CATCH BLOCKS — Handle errors that happen DURING the above steps
      // ================================================================
    } on DioException catch (e) {
      // ---- NETWORK ERROR ----
      // The request didn't even reach the server
      // Causes: No internet, timeout, DNS failure
      //
      // DioExceptionType values:
      // .connectionTimeout  → "Taking too long to connect"
      // .receiveTimeout     → "Server too slow to respond"
      // .connectionError    → "No internet / server down"
      // .badResponse        → "Server returned HTTP error" (rare for your API)
      // .cancel             → "Request was cancelled"
      //
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          throw NetworkException(
            message: 'Connection timed out. Please try again.',
          );
        case DioExceptionType.connectionError:
          throw NetworkException(
            message: 'No internet connection. Please check your WiFi.',
          );
        default:
          throw NetworkException(message: 'Network error. Please try again.');
      }
    } on SessionExpiredException {
      // ---- SESSION EXPIRED ----
      // Already the right exception type, just pass it up
      rethrow;
    } on ApiException {
      // ---- API ERROR ----
      // Already the right exception type, just pass it up
      rethrow;
    } catch (e) {
      // ---- UNEXPECTED ERROR ----
      // JSON parsing failed, null error, or any other crash
      throw ApiException(errorCode: 0, message: 'Something went wrong: $e');
    }
  }
}
