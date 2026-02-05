import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_constants.dart';

class ApiClient {
  // Private constructor to prevent instantiation
  ApiClient._();

  // Singleton Dio instance
  static final Dio _dio =
      Dio(
          BaseOptions(
            baseUrl: ApiConstants.fullBaseUrl,
            headers: ApiConstants.headers,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          ),
        )
        ..interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
          ),
        );

  // Getter to access the Dio instance
  static Dio get dio => _dio;
}
