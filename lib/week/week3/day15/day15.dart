import 'package:dio/dio.dart';
import 'package:learning_2/core/api/api_client.dart';
import 'package:learning_2/core/api/exceptions.dart';
import 'package:learning_2/week/week2/day11.dart';

class ApiService {
  final Dio _dio = ApiClient.dio;

  static const String _endpoint = '/vocoxp/api/livelink_user_list_ver_1.2.php';

  Future<ProjectResponse> fetchTasks({
    required String locationId,
    required int verificationOf,
    required String fromDate,
    required String toDate,
    required int page,
    String statusType = 'All',
    int limit = 10,
  }) async {
    try {
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

      if (response.data == null) {
        throw ApiException(message: "Empty response from server", errorCode: 0);
      }

      final Map<String, dynamic> data = response.data;
      final int errorCode = data['error_code'] ?? 0;
      final String message = data['message'] ?? '';
      final String responseCode = data['response_code'] ?? '';

      switch (errorCode) {
        case 100:
          return ProjectResponse.fromJson(data);
        case 440:
          throw SessionExpiredException(message: "Session Expired");
        default:
          throw ApiException(
            message: message,
            errorCode: errorCode,
            responseCode: responseCode,
          );
      }
    } on DioException catch (e) {
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
      rethrow;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(errorCode: 0, message: 'Something went wrong: $e');
    }
  }
}
