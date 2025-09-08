class ServerException implements Exception {
  final String message;
  ServerException([this.message = "Server error"]);
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException([this.message = "Unauthorized"]);
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = "Cache error"]);
}
