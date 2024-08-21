import 'package:dartz/dartz.dart';
import 'package:students/core/errors/exception.dart';
import 'package:students/core/errors/failure.dart';
import 'package:students/core/typedef/typedef.dart';
import 'package:students/src/student/data/datasource/student_remote_datasource.dart';
import 'package:students/src/student/domain/entities/student_scores.dart';
import 'package:students/src/student/domain/repos/student_scores_repository.dart';

class StudentScoresRepositoryImplementation implements StudentScoresRepository {
  final StudentRemoteDatasource _remoteDatasource;

  StudentScoresRepositoryImplementation(
      {required StudentRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  ResultVoid createScore(
      {required String studentid,
      required int english,
      required int kiswahili,
      required int math,
      required int science,
      required int sstandcre}) async {
    try {
      await _remoteDatasource.createScore(
          studentid: studentid,
          english: english,
          kiswahili: kiswahili,
          math: math,
          science: science,
          sstandcre: sstandcre);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteScore({required String id}) async {
    try {
      await _remoteDatasource.deleteScore(id: id);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<StudentScores> getScore({required String id}) async {
    try {
      final result = await _remoteDatasource.getScore(id: id);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<StudentScores>> getScores() async {
    try {
      final result = await _remoteDatasource.getScores();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid udpateScore(
      {required String id, required StudentScores scores}) async {
    try {
      await _remoteDatasource.udpateScore(id: id, scores: scores);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
