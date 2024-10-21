class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException([this.message = 'Unauthorized access']);

  @override
  String toString() => 'UnauthorizedException: $message';
}

class ChangePasswordException implements Exception {
  final String message;

  ChangePasswordException([this.message = 'Change Password']);

  @override
  String toString() => message;
}

class DetailException implements Exception{
  final String message;

  DetailException(this.message);

  @override
  String toString() => message;
}
