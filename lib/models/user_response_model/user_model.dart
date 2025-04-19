// ignore_for_file:  non_constant_identifier_names

import 'package:doctopia_doctors/models/user_response_model/user_preferences.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String username;
  final String name;
  final String? email;
  final String service_id;
  final String phone;
  final String? password;
  final int synd_id;
  final String? fcm_token;
  final UserPreferences? preferences;
  final bool emailVisibility;

  const UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.password,
    required this.email,
    required this.service_id,
    required this.phone,
    required this.synd_id,
    this.fcm_token,
    this.preferences,
    this.emailVisibility = true,
  });

  @override
  List<Object?> get props {
    return [
      id,
      username,
      name,
      password,
      email,
      service_id,
      phone,
      synd_id,
      fcm_token,
      preferences,
      emailVisibility,
    ];
  }

  UserModel copyWith({
    String? id,
    String? username,
    String? name,
    String? email,
    String? service_id,
    String? password,
    String? phone,
    int? synd_id,
    String? fcm_token,
    UserPreferences? preferences,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      service_id: service_id ?? this.service_id,
      phone: phone ?? this.phone,
      synd_id: synd_id ?? this.synd_id,
      fcm_token: fcm_token ?? this.fcm_token,
      preferences: preferences ?? this.preferences,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'service_id': service_id,
      'phone': phone,
      'synd_id': synd_id,
      'password': password,
      'passwordConfirm': password,
      'fcm_token': fcm_token,
      'preferences': preferences?.toJson(),
      'emailVisibility': emailVisibility,
    };
  }

  Map<String, dynamic> toPocketbaseJson() {
    return <String, dynamic>{
      'username': username,
      'name': name,
      'email': email,
      'service_id': service_id,
      'phone': phone,
      'synd_id': synd_id,
      'password': password,
      'passwordConfirm': password,
      'fcm_token': fcm_token,
      'preferences': preferences?.toJson(),
      'emailVisibility': emailVisibility,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      username: map['username'] as String,
      name: map['name'] as String,
      email: map['email'] as String?,
      service_id: map['service_id'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String?,
      synd_id: map['synd_id'] as int,
      fcm_token: map['fcm_token'] as String?,
      preferences: map['preferences'] == null
          ? null
          : UserPreferences.fromJson(
              map['preferences'] as Map<String, dynamic>),
    );
  }

  @override
  bool get stringify => true;
}
