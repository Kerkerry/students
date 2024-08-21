import 'package:get_it/get_it.dart';
import 'package:students/src/auth/data/datasource/auth_remote_datasource.dart';
import 'package:students/src/auth/data/datasource/auth_remote_datasource_implementation.dart';
import 'package:students/src/auth/data/repos/user_repository_implementation.dart';
import 'package:students/src/auth/domain/repos/user_repository.dart';
import 'package:students/src/auth/domain/usecase/create_user.dart';
import 'package:students/src/auth/domain/usecase/delete_user.dart';
import 'package:students/src/auth/domain/usecase/get_user.dart';
import 'package:students/src/auth/domain/usecase/get_users.dart';
import 'package:students/src/auth/domain/usecase/update_user.dart';
import 'package:students/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:students/src/student/data/datasource/student_remote_datasource.dart';
import 'package:students/src/student/data/datasource/student_remote_datasource_implementation.dart';
import 'package:students/src/student/data/repos/student_scores_repository_implementation.dart';
import 'package:students/src/student/domain/repos/student_scores_repository.dart';
import 'package:students/src/student/domain/usecase/create_student_scores.dart';
import 'package:students/src/student/domain/usecase/delete_student_scores.dart';
import 'package:students/src/student/domain/usecase/get_student_scores.dart';
import 'package:students/src/student/domain/usecase/get_students_scores.dart';
import 'package:students/src/student/domain/usecase/update_student_scores.dart';
import 'package:students/src/student/presentation/bloc/student_scores_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerFactory(() => AuthBloc(
        createUser: sl(),
        deleteUser: sl(),
        updateUser: sl(),
        getUser: sl(),
        getUsers: sl()))
    ..registerLazySingleton(() => CreateUser(repository: sl()))
    ..registerLazySingleton(() => DeleteUser(repository: sl()))
    ..registerLazySingleton(() => UpdateUser(repository: sl()))
    ..registerLazySingleton(() => GetUser(repository: sl()))
    ..registerLazySingleton(() => GetUsers(repository: sl()))
    ..registerLazySingleton<UserRepository>(
        () => UserRepositoryImplementation(remoteDatasource: sl()))
    ..registerLazySingleton<RemoteDatasource>(
        () => RemoteDatasourceImplementation(client: sl()))
    ..registerFactory(() => StudentScoresBloc(
        createStudentScores: sl(),
        deleteStudentScores: sl(),
        updateStudentScores: sl(),
        getStudentScores: sl(),
        getStudentsScores: sl()))
    ..registerLazySingleton(() => CreateStudentScores(repository: sl()))
    ..registerLazySingleton(() => DeleteStudentScores(repository: sl()))
    ..registerLazySingleton(() => UpdateStudentScores(repository: sl()))
    ..registerLazySingleton(() => GetStudentScores(repository: sl()))
    ..registerLazySingleton(() => GetStudentsScores(repository: sl()))
    ..registerLazySingleton<StudentScoresRepository>(
        () => StudentScoresRepositoryImplementation(remoteDatasource: sl()))
    ..registerLazySingleton<StudentRemoteDatasource>(
        () => StudentRemoteDatasourceImplementation(client: sl()))
    ..registerLazySingleton(() => http.Client());
}
