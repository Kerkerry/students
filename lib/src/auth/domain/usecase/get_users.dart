import 'package:students/core/typedef/typedef.dart';
import 'package:students/core/usecases/usecase.dart';
import 'package:students/src/auth/domain/entities/user.dart';
import 'package:students/src/auth/domain/repos/user_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  final UserRepository _repository;

  GetUsers({required UserRepository repository}) : _repository = repository;
  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}
