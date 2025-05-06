//getting exception from the server error
class ServerFailure implements Exception {
  final String message;

  ServerFailure(this.message);
}
