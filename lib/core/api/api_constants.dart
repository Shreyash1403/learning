class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://vocoxp.staffhandler.com';

  // API Path
  static const String apiPath = '/vocoxp/tenant/tenant_backend/api/tenant';

  // Full Base URL
  static const String fullBaseUrl = '$baseUrl$apiPath';

  // ============= HEADERS =============
  // These are sent with EVERY request
  static const String headerAgencyId = 'Agency-Id';
  static const String headerAppToken = 'App-Token';
  static const String headerVersion = 'Version';

  static const String agencyId = 'AGN-00008';
  static const String appToken = '57a1157beb28ad8eaf7c74178d52c599';
  static const String version = '1.0';

  static Map<String, String> headers = {
    headerAgencyId: agencyId,
    headerAppToken: appToken,
    headerVersion: version,
  };

  // ============= ENDPOINTS =============
  // Complaints endpoint
  static const String complaintsEndpoint = '/complaint-homepage';
}
