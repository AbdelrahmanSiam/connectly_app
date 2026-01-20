class AuthException implements Exception {
  final String message;
  
  AuthException(this.message);
}

class UserNotFoundException extends AuthException {
  UserNotFoundException() : super('No user found for that email.');
}

class WrongPasswordException extends AuthException {
  WrongPasswordException() : super('Wrong password provided for that user.');
}
class EmailAlreadyIsUsedException extends AuthException {
  EmailAlreadyIsUsedException() : super('The account already exists for that email.');
}
class WeakPasswordException extends AuthException {
  WeakPasswordException() : super('The password provided is too weak.');
}
class NetworkException extends AuthException {
  NetworkException() : super('Network error occurred.');
}