import 'package:students/core/typedef/typedef.dart';
import 'package:students/core/usecases/usecase.dart';
import 'package:students/src/auth/domain/entities/user.dart';
import 'package:students/src/auth/domain/repos/user_repository.dart';

class GetUser extends UsecaseWithParams<User, String> {
  final UserRepository _repository;

  GetUser({required UserRepository repository}) : _repository = repository;

  @override
  ResultFuture<User> call(String params) async =>
      _repository.getUser(id: params);
}
