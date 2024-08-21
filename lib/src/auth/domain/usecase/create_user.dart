import 'package:equatable/equatable.dart';
import 'package:students/core/typedef/typedef.dart';
import 'package:students/core/usecases/usecase.dart';
import 'package:students/src/auth/domain/repos/user_repository.dart';

class CreateUser extends UsecaseWithParams<void, UserParams> {
  final UserRepository _repository;

  CreateUser({required UserRepository repository}) : _repository = repository;

  @override
  ResultFuture<void> call(UserParams params) async => _repository.createUser(
      firstname: params.firstname,
      secondname: params.secondname,
      email: params.email,
      password: params.password);
}

class UserParams extends Equatable {
  final String firstname;
  final String secondname;
  final String email;
  final String password;

  const UserParams(
      {required this.firstname,
      required this.secondname,
      required this.email,
      required this.password});

  @override
  List<Object?> get props => [firstname, secondname, email, password];

  const UserParams.empty()
      : this(
            firstname: "John",
            secondname: "Doe",
            email: "johndoe@example.com",
            password: "johndoe");
}
