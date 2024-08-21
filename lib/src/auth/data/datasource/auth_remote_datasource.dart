import 'package:students/src/auth/domain/entities/user.dart';

abstract class RemoteDatasource {
  const RemoteDatasource();
  Future createUser(
      {required String firstname,
      required String secondname,
      required String email,
      required String password});
  Future udpateUser({required String id, required User user});
  Future deleteUser({required String id});
  Future<User> getUser({required String id});
  Future<List<User>> getUsers();
}
