class ApiException implements Exception {
  final String message;
  final int errorCode;
  final String? responseCode;

  const ApiException({
    required this.message,
    required this.errorCode,
    this.responseCode,
  });

  @override
  String toString() => "ApiException: $message ($errorCode)";
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({required this.message});

  @override
  String toString() => "NetworkException: $message";
}

class SessionExpiredException implements Exception {
  final String message;

  const SessionExpiredException({required this.message});

  @override
  String toString() => "SessionExpiredException: $message";
}
