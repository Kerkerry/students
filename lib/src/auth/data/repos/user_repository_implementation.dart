import 'package:dartz/dartz.dart';
import 'package:students/core/errors/exception.dart';
import 'package:students/core/errors/failure.dart';
import 'package:students/core/typedef/typedef.dart';
import 'package:students/src/auth/data/datasource/auth_remote_datasource.dart';
import 'package:students/src/auth/domain/entities/user.dart';
import 'package:students/src/auth/domain/repos/user_repository.dart';

class UserRepositoryImplementation extends UserRepository {
  final RemoteDatasource _remoteDatasource;

  UserRepositoryImplementation({required RemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  ResultVoid createUser(
      {required String firstname,
      required String secondname,
      required String email,
      required String password}) async {
    try {
      await _remoteDatasource.createUser(
          firstname: firstname,
          secondname: secondname,
          email: email,
          password: password);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteUser({required String id}) async {
    try {
      await _remoteDatasource.deleteUser(id: id);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<User> getUser({required String id}) async {
    try {
      final result = await _remoteDatasource.getUser(id: id);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDatasource.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid udpateUser({required String id, required User user}) async {
    try {
      await _remoteDatasource.udpateUser(id: id, user: user);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
