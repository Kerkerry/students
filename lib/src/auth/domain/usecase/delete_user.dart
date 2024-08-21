import 'package:students/core/typedef/typedef.dart';
import 'package:students/core/usecases/usecase.dart';
import 'package:students/src/auth/domain/repos/user_repository.dart';

class DeleteUser extends UsecaseWithParams<void, String> {
  final UserRepository _repository;

  DeleteUser({required UserRepository repository}) : _repository = repository;
  @override
  ResultFuture<void> call(String params) async =>
      _repository.deleteUser(id: params);
}
