import 'package:students/core/typedef/typedef.dart';
import 'package:students/src/auth/domain/entities/user.dart';

abstract class UserRepository {
  const UserRepository();

  ResultVoid createUser(
      {required String firstname,
      required String secondname,
      required String email,
      required String password});
  ResultVoid udpateUser({required String id, required User user});
  ResultVoid deleteUser({required String id});
  ResultFuture<User> getUser({required String id});
  ResultFuture<List<User>> getUsers();
}
