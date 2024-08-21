import 'package:students/core/typedef/typedef.dart';
import 'package:students/core/usecases/usecase.dart';
import 'package:students/src/auth/domain/entities/user.dart';
import 'package:students/src/auth/domain/repos/user_repository.dart';

class UpdateUser extends UsecaseWithParams<void, User> {
  final UserRepository _repository;

  UpdateUser({required UserRepository repository}) : _repository = repository;

  @override
  ResultFuture<void> call(User params) async =>
      _repository.udpateUser(id: params.id, user: params);
}
