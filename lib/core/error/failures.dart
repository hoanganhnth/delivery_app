abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = "Server Failure"]);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = "Unauthorized"]);
}
