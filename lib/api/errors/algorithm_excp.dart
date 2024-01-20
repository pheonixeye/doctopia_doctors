class CreateAlgorithmException implements Exception {
  final int errorCode;
  final String message;
  CreateAlgorithmException(this.errorCode)
      : message = 'Algorithm Failed...\nErrorCode:$errorCode';

  @override
  String toString() {
    return message;
  }
}
