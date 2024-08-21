import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String firstname;
  final String secondname;
  final String email;
  final String password;

  const User(
      {required this.id,
      required this.firstname,
      required this.secondname,
      required this.email,
      required this.password});

  @override
  List<Object?> get props => [firstname, secondname, email, password];
}
