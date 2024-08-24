import 'dart:convert';

import 'package:students/core/constants/app_constants.dart';
import 'package:students/core/errors/exception.dart';
import 'package:students/core/helper/logger_helper.dart';
import 'package:students/core/typedef/typedef.dart';
import 'package:students/src/auth/data/datasource/auth_remote_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:students/src/auth/data/models/user_model.dart';
import 'package:students/src/auth/domain/entities/user.dart';

class RemoteDatasourceImplementation implements RemoteDatasource {
  final http.Client _client;

  RemoteDatasourceImplementation({required http.Client client})
      : _client = client;

  @override
  Future createUser(
      {required String firstname,
      required String secondname,
      required String email,
      required String password}) async {
    try {
      final student = jsonEncode({
        'firstname': firstname,
        'secondname': secondname,
        'email': email,
        'password': password
      });
      final response = await _client.post(
        Uri.https(kBaseUrl, "/create-student/$student"),
        headers: headers,
      );
      if (response.statusCode != 200) {
        logger.e("${response.statusCode} ${response.body}");
        throw (APIException(
            statusCode: response.statusCode, message: response.body));
      }
    } catch (e) {
      throw (APIException(statusCode: 505, message: e.toString()));
    }
  }

  @override
  Future deleteUser({required String id}) async {
    try {
      final response = await _client
          .delete(Uri.https(kBaseUrl, "/delete-student/$id"), headers: headers);
      if (response.statusCode != 200) {
        throw (APIException(
            statusCode: response.statusCode, message: response.body));
      }
    } catch (e) {
      throw (APIException(statusCode: 505, message: e.toString()));
    }
  }

  @override
  Future<User> getUser({required String id}) async {
    try {
      final response = await _client
          .get(Uri.https(kBaseUrl, "$kGetUserEndpoint/$id"), headers: headers);
      if (response.statusCode != 200) {
        throw (APIException(
            statusCode: response.statusCode, message: response.body));
      }

      return UserModel.fromJson(response.body);
    } catch (e) {
      throw (APIException(statusCode: 505, message: e.toString()));
    }
  }

  @override
  Future<List<User>> getUsers() async {
    try {
      final response = await _client.get(Uri.https(kBaseUrl, kGetUsersEndpoint),
          headers: headers);
      if (response.statusCode != 200) {
        throw (APIException(
            statusCode: response.statusCode, message: response.body));
      }
      logger.e(response.body);
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((user) => UserModel.fromMap(user))
          .toList();
    } catch (e) {
      throw (APIException(statusCode: 505, message: e.toString()));
    }
  }

  @override
  Future udpateUser({required String id, required User user}) async {
    try {
      final student = jsonEncode({
        "id": id,
        'firstname': user.firstname,
        'secondname': user.secondname,
        'email': user.email,
        'password': user.password
      });
      final response = await _client.put(
          Uri.https(kBaseUrl, "/update-student/$student"),
          headers: headers);
      if (response.statusCode != 200) {
        throw (APIException(
            statusCode: response.statusCode, message: response.body));
      }
    } catch (e) {
      throw (APIException(statusCode: 505, message: e.toString()));
    }
  }
}
