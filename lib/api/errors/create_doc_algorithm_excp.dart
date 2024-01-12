class CreateDoctorAlgorithmException implements Exception {
  final int errorCode;
  final String message;
  CreateDoctorAlgorithmException(this.errorCode)
      : message = 'Doctor Registeration Failed...\nErrorCode:$errorCode';

  @override
  String toString() {
    return message;
  }
}
