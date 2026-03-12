import 'dart:convert';

import 'package:task_project/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.image,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      image: json['image'] as String? ?? '',
      token: json['accessToken'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
      'accessToken': token,
    };
  }

  String toJsonString() => json.encode(toJson());

  factory UserModel.fromJsonString(String source) {
    return UserModel.fromJson(json.decode(source) as Map<String, dynamic>);
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      username: entity.username,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      image: entity.image,
      token: entity.token,
    );
  }
}
