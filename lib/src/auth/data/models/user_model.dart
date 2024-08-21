import 'dart:convert';

import 'package:students/core/typedef/typedef.dart';
import 'package:students/src/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.firstname,
      required super.secondname,
      required super.email,
      required super.password});

  UserModel.fromMap(DataMap map)
      : this(
            id: map['_id'],
            firstname: map['firstname'],
            secondname: map['secondname'],
            email: map['useremail'],
            password: map['password']);
  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  UserModel copyWith(
      {String? firstname,
      String? secondname,
      String? email,
      String? password}) {
    return UserModel(
        id: id,
        firstname: firstname ?? this.firstname,
        secondname: secondname ?? this.secondname,
        email: email ?? this.email,
        password: password ?? this.password);
  }

  DataMap toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'secondname': secondname,
      'email': email,
      'password': password
    };
  }

  String toJson() => jsonEncode(toMap());
}
