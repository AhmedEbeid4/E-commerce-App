class BadResponseException implements Exception {
  final int statusCode;
  String message;

  BadResponseException(this.statusCode, this.message);
}

class NotVerifiedException implements Exception {}
