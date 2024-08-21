part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class CreatingUserState extends AuthState {
  const CreatingUserState();
}

class UserCreatedState extends AuthState {
  const UserCreatedState();
}

class GettingUsersState extends AuthState {
  const GettingUsersState();
}

class UsersLoadedState extends AuthState {
  final List<User> users;

  const UsersLoadedState({required this.users});

  @override
  List<String> get props => users.map((user) => user.id).toList();
}

class GettingUserState extends AuthState {
  const GettingUserState();
}

class UserLoadedState extends AuthState {
  final User user;

  const UserLoadedState({required this.user});

  @override
  List<String> get props => [user.id];
}

class UpdatingUserState extends AuthState {
  const UpdatingUserState();
}

class UserUpdatedState extends AuthState {
  const UserUpdatedState();
}

class DeletingUserState extends AuthState {
  const DeletingUserState();
}

class UserDeletedState extends AuthState {
  const UserDeletedState();
}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState({required this.message});

  @override
  List<String> get props => [message];
}
