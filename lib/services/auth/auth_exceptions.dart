//login exception
class UserNotFoundException implements Exception {}

class WrongPasswordAuthException implements Exception {}

//register exception
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseException implements Exception {}

class InvalidEmailAuthExcaption implements Exception {}

//generic exception
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
