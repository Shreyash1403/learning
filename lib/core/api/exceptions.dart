// ======================================================================
// CUSTOM EXCEPTION CLASSES
// ======================================================================
//
// WHY separate exception classes?
//
// Because different errors need DIFFERENT handling in UI:
//
// ┌──────────────────────┬──────────────────────────────────────────────┐
// │ Exception Type       │ What UI Does                                 │
// ├──────────────────────┼──────────────────────────────────────────────┤
// │ ApiException         │ Show error message as toast/snackbar         │
// │ SessionExpired       │ Navigate to LOGIN screen (not just a toast!) │
// │ NetworkException     │ Show "Check your internet" message           │
// └──────────────────────┴──────────────────────────────────────────────┘
//
// If we used just one Exception for everything, BLoC wouldn't know
// whether to show a toast OR navigate to login. That's why we separate.
// ======================================================================

/// API error — server responded but with an error_code
/// Examples: 302 (agency inactive), 310 (invalid location), 105 (no data)
///
/// UI Action: Show error message to user (toast/snackbar/dialog)
class ApiException implements Exception {
  final int errorCode;
  final String message;
  final String responseCode;

  ApiException({
    required this.errorCode,
    required this.message,
    this.responseCode = '',
  });

  @override
  String toString() => 'ApiException($errorCode): $message';
}

/// Session expired — error_code 440
/// This is separate because it needs COMPLETELY different handling
///
/// UI Action: Navigate to login screen + clear stored session data
class SessionExpiredException implements Exception {
  final String message;

  SessionExpiredException({
    this.message = 'Session expired. Please login again.',
  });

  @override
  String toString() => 'SessionExpired: $message';
}

/// Network error — request didn't even reach the server
/// Examples: No WiFi, timeout, DNS failure, server down
///
/// UI Action: Show "Check your internet connection" message
class NetworkException implements Exception {
  final String message;

  NetworkException({this.message = 'Please check your internet connection.'});

  @override
  String toString() => 'NetworkError: $message';
}
