class ServerException implements Exception {}

class CustomFirebaseException implements Exception {
  String? message;
  String? code;
  CustomFirebaseException({this.message, this.code});
}
