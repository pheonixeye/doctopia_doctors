class ConnectionException implements Exception {
  final int errorCode;
  final String message;
  ConnectionException(this.errorCode)
      : message = switch (errorCode) {
          1 =>
            'No Internet Connection Detected, Check Your Internet Connection and Try Again Later.',
          // 1 => 'Our Servers are Offline, Kindly Try Again Later.',
          _ => 'Unknown Error.',
        };

  @override
  String toString() {
    return message;
  }
}
