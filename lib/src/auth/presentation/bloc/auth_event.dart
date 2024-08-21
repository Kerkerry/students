part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CreatingUserEvent extends AuthEvent {
  final String firstname;
  final String secondname;
  final String email;
  final String password;

  const CreatingUserEvent(
      {required this.firstname,
      required this.secondname,
      required this.email,
      required this.password});

  @override
  List<Object> get props => [firstname, secondname, email, password];
}

class UpdateUserEvent extends AuthEvent {
  final User user;
  const UpdateUserEvent({required this.user});
}

class DeleteUserEvent extends AuthEvent {
  final String id;
  const DeleteUserEvent({required this.id});
}

class GetUserEvent extends AuthEvent {
  final String id;

  const GetUserEvent({required this.id});
}

class GetUsersEvent extends AuthEvent {
  const GetUsersEvent();
}
