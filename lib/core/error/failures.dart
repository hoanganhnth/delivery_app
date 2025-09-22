abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'Failure(message: $message)';
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = "Server Failure"]);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = "Unauthorized"]);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message = "Validation Error"]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = "Network Error"]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = "Cache Error"]);
}

class LocationFailure extends Failure {
  const LocationFailure([super.message = "Location Error"]);
}
