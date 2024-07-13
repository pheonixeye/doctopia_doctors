// import 'dart:convert';
// import 'dart:math';

// import 'package:crypto/crypto.dart';

// class SaltedPassword {
//   final String salt;
//   final String password;

//   const SaltedPassword({
//     required this.salt,
//     required this.password,
//   });
// }

// SaltedPassword generatePasswordHash(String password) {
//   //retrieve password
//   //generate salt
//   Random random = Random();
//   List<int> saltBytes = List<int>.generate(32, (index) => random.nextInt(256));
//   String salt = base64.encode(saltBytes);
//   //hash password
//   var key = utf8.encode(password);
//   var bytes = utf8.encode(salt);

//   var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
//   var digest = hmacSha256.convert(bytes);
//   return SaltedPassword(
//     salt: salt,
//     password: digest.toString(),
//   );
// }

// String retrievePassword(String password, String salt) {
//   //retrieve password

//   //hash password
//   var key = utf8.encode(password);
//   var bytes = utf8.encode(salt);

//   var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
//   var digest = hmacSha256.convert(bytes);
//   return digest.toString();
// }

// class WrongPasswordException implements Exception {
//   final String message;

//   WrongPasswordException({required this.message});

//   @override
//   String toString() => message;
// }
