class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://dummyjson.com';

  // Auth
  static const String login = '/auth/login';

  // Products
  static const String products = '/products';

  // Posts
  static const String posts = '/posts';

  // Timeouts (in milliseconds)
  static const int connectTimeout = 15000;
  static const int receiveTimeout = 15000;
  static const int sendTimeout = 15000;
}
