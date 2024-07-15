// ignore_for_file:  non_constant_identifier_names

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String username;
  final String? email;
  final String service;
  final String phone;
  final String? password;
  final int synd_id;
  final String? fcm_token;

  const UserModel({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.service,
    required this.phone,
    required this.synd_id,
    this.fcm_token,
  });

  @override
  List<Object?> get props {
    return [
      id,
      username,
      password,
      email,
      service,
      phone,
      synd_id,
      fcm_token,
    ];
  }

  UserModel copyWith(
      {String? id,
      String? username,
      String? email,
      String? service,
      String? password,
      String? phone,
      int? synd_id,
      String? fcm_token}) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      service: service ?? this.service,
      phone: phone ?? this.phone,
      synd_id: synd_id ?? this.synd_id,
      fcm_token: fcm_token ?? this.fcm_token,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'service': service,
      'phone': phone,
      'synd_id': synd_id,
      'password': password,
      'passwordConfirm': password,
      'fcm_token': fcm_token,
    };
  }

  Map<String, dynamic> toPocketbaseJson() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'service': service,
      'phone': phone,
      'synd_id': synd_id,
      'password': password,
      'passwordConfirm': password,
      'fcm_token': fcm_token,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      username: map['username'] as String,
      email: map['email'] as String?,
      service: map['service'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String?,
      synd_id: map['synd_id'] as int,
      fcm_token: map['fcm_token'] as String?,
    );
  }

  @override
  bool get stringify => true;
}
