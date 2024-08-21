import 'dart:convert';

import 'package:students/core/constants/app_constants.dart';
import 'package:students/core/errors/exception.dart';
import 'package:students/core/typedef/typedef.dart';
import 'package:students/src/student/data/datasource/student_remote_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:students/src/student/data/models/student_scores_model.dart';
import 'package:students/src/student/domain/entities/student_scores.dart';

class StudentRemoteDatasourceImplementation implements StudentRemoteDatasource {
  final http.Client _client;

  StudentRemoteDatasourceImplementation({required http.Client client})
      : _client = client;

  @override
  Future createScore(
      {required String studentid,
      required int english,
      required int kiswahili,
      required int math,
      required int science,
      required int sstandcre}) async {
    try {
      final scores = jsonEncode({
        'studentid': studentid,
        'english': english,
        'kiswahili': kiswahili,
        'math': math,
        'science': science,
        'sstandcre': sstandcre
      });
      final response = await _client.post(
        Uri.https(kBaseUrl, "$kCreateStudentScoreEndpoint/$scores"),
        headers: headers,
      );
      if (response.statusCode != 200) {
        throw (APIException(
            statusCode: response.statusCode, message: response.body));
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw (APIException(statusCode: 505, message: e.toString()));
    }
  }

  @override
  Future deleteScore({required String id}) async {
    try {
      final response = await _client.delete(
        Uri.https(kBaseUrl, '$kDeleteStudentScoreEndpoint/$id'),
        headers: headers,
      );
      if (response.statusCode != 200) {
        throw (APIException(
            statusCode: response.statusCode, message: response.body));
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw (APIException(statusCode: 505, message: e.toString()));
    }
  }

  @override
  Future<StudentScores> getScore({required String id}) async {
    try {
      final response = await _client.get(
        Uri.https(kBaseUrl, '$kGetStudentScoreEndpoint/$id'),
        headers: headers,
      );
      if (response.statusCode != 200) {
        throw (APIException(
            statusCode: response.statusCode, message: response.body));
      }
      return StudentScoresModel.fromJson(response.body);
    } on APIException {
      rethrow;
    } catch (e) {
      throw (APIException(statusCode: 505, message: e.toString()));
    }
  }

  @override
  Future<List<StudentScores>> getScores() async {
    try {
      final response = await _client.get(
        Uri.https(kBaseUrl, kGetStudentScoreEndpoint),
        headers: headers,
      );
      if (response.statusCode != 200) {
        throw (APIException(
            statusCode: response.statusCode, message: response.body));
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((score) => StudentScoresModel.fromMap(score))
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw (APIException(statusCode: 505, message: e.toString()));
    }
  }

  @override
  Future udpateScore(
      {required String id, required StudentScores scores}) async {
    try {
      final response = await _client.put(
        Uri.https(kBaseUrl, kGetStudentScoreEndpoint),
        body: jsonEncode({
          'id': id,
          'studentid': scores.studentid,
          'english': scores.english,
          'kiswahili': scores.kiswahili,
          'math': scores.math,
          'science': scores.science,
          'sstandcre': scores.sstandcre
        }),
        headers: headers,
      );
      if (response.statusCode != 200) {
        throw (APIException(
            statusCode: response.statusCode, message: response.body));
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw (APIException(statusCode: 505, message: e.toString()));
    }
  }
}
