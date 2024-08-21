import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:students/src/auth/domain/entities/user.dart';
import 'package:students/src/auth/domain/usecase/create_user.dart';
import 'package:students/src/auth/domain/usecase/delete_user.dart';
import 'package:students/src/auth/domain/usecase/get_user.dart';
import 'package:students/src/auth/domain/usecase/get_users.dart';
import 'package:students/src/auth/domain/usecase/update_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateUser _createUser;
  final DeleteUser _deleteUser;
  final UpdateUser _updateUser;
  final GetUser _getUser;
  final GetUsers _getUsers;

  AuthBloc(
      {required CreateUser createUser,
      required DeleteUser deleteUser,
      required UpdateUser updateUser,
      required GetUser getUser,
      required GetUsers getUsers})
      : _createUser = createUser,
        _deleteUser = deleteUser,
        _updateUser = updateUser,
        _getUser = getUser,
        _getUsers = getUsers,
        super(AuthInitial()) {
    on<CreatingUserEvent>(_createUserHandler);
    on<DeleteUserEvent>(_deleteUserHandler);
    on<UpdateUserEvent>(_updateUserHandler);
    on<GetUserEvent>(_getUserHandler);
    on<GetUsersEvent>(_getUsersHandler);
  }

  FutureOr<void> _createUserHandler(
      CreatingUserEvent event, Emitter<AuthState> emit) async {
    emit(const CreatingUserState());
    final result = await _createUser(UserParams(
        firstname: event.firstname,
        secondname: event.secondname,
        email: event.email,
        password: event.password));
    result.fold((failure) => emit(AuthErrorState(message: failure.message)),
        (_) => emit(const UserCreatedState()));
  }

  FutureOr<void> _deleteUserHandler(
      DeleteUserEvent event, Emitter<AuthState> emit) async {
    emit(const DeletingUserState());
    final result = await _deleteUser(event.id);
    result.fold((failure) => emit(AuthErrorState(message: failure.message)),
        (_) => emit(const UserDeletedState()));
  }

  FutureOr<void> _updateUserHandler(
      UpdateUserEvent event, Emitter<AuthState> emit) async {
    emit(const UpdatingUserState());
    final result = await _updateUser(event.user);
    result.fold((failure) => emit(AuthErrorState(message: failure.message)),
        (_) => emit(const UserUpdatedState()));
  }

  FutureOr<void> _getUserHandler(
      GetUserEvent event, Emitter<AuthState> emit) async {
    emit(const GettingUserState());
    final result = await _getUser(event.id);
    result.fold((failure) => emit(AuthErrorState(message: failure.message)),
        (user) => emit(UserLoadedState(user: user)));
  }

  FutureOr<void> _getUsersHandler(
      GetUsersEvent event, Emitter<AuthState> emit) async {
    emit(const GettingUserState());
    final result = await _getUsers();
    result.fold((failure) => emit(AuthErrorState(message: failure.message)),
        (users) => emit(UsersLoadedState(users: users)));
  }
}
