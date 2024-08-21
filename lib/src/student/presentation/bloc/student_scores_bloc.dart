import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:students/src/student/domain/entities/student_scores.dart';
import 'package:students/src/student/domain/usecase/create_student_scores.dart';
import 'package:students/src/student/domain/usecase/delete_student_scores.dart';
import 'package:students/src/student/domain/usecase/get_student_scores.dart';
import 'package:students/src/student/domain/usecase/get_students_scores.dart';
import 'package:students/src/student/domain/usecase/update_student_scores.dart';

part 'student_scores_event.dart';
part 'student_scores_state.dart';

class StudentScoresBloc extends Bloc<StudentScoresEvent, StudentScoresState> {
  final CreateStudentScores _createStudentScores;
  final DeleteStudentScores _deleteStudentScores;
  final UpdateStudentScores _updateStudentScores;
  final GetStudentScores _getStudentScores;
  final GetStudentsScores _getStudentsScores;

  StudentScoresBloc(
      {required CreateStudentScores createStudentScores,
      required DeleteStudentScores deleteStudentScores,
      required UpdateStudentScores updateStudentScores,
      required GetStudentScores getStudentScores,
      required GetStudentsScores getStudentsScores})
      : _createStudentScores = createStudentScores,
        _deleteStudentScores = deleteStudentScores,
        _updateStudentScores = updateStudentScores,
        _getStudentScores = getStudentScores,
        _getStudentsScores = getStudentsScores,
        super(StudentScoresInitial()) {
    on<CreatingStudentScoreEvent>(_createStudentScoresHandler);
    on<DeleteStudentScoreEvent>(_deleteStudentScoresHandler);
    on<UpdateStudentScoreEvent>(_updateStudentScoresHandler);
    on<GetStudentScoreEvent>(_getStudentScoresHandler);
    on<GetStudentScoresEvent>(_getStudentsScoresHandler);
  }

  FutureOr<void> _createStudentScoresHandler(
      CreatingStudentScoreEvent event, Emitter<StudentScoresState> emit) async {
    emit(const CreatingStudentScoresState());
    final result = await _createStudentScores(StudentScoresParams(
        studentid: event.studentid,
        english: event.english,
        kiswahili: event.kiswahili,
        math: event.math,
        science: event.science,
        sstandcre: event.sstandcre));
    result.fold(
        (failure) => emit(StudentScoresErrorState(message: failure.message)),
        (_) => emit(const StudentScoresCreatedState()));
  }

  FutureOr<void> _deleteStudentScoresHandler(
      DeleteStudentScoreEvent event, Emitter<StudentScoresState> emit) async {
    emit(const DeletingStudentScoresState());
    final result = await _deleteStudentScores(event.id);
    result.fold(
        (failure) => emit(StudentScoresErrorState(message: failure.message)),
        (_) => emit(const StudentScoresDeletedState()));
  }

  FutureOr<void> _updateStudentScoresHandler(
      UpdateStudentScoreEvent event, Emitter<StudentScoresState> emit) async {
    emit(const UpdatingStudentScoresState());
    final result = await _updateStudentScores(event.score);
    result.fold(
        (failure) => emit(StudentScoresErrorState(message: failure.message)),
        (_) => emit(const StudentScoresUpdatedState()));
  }

  FutureOr<void> _getStudentScoresHandler(
      GetStudentScoreEvent event, Emitter<StudentScoresState> emit) async {
    emit(const GettingStudentScoresState());
    final result = await _getStudentScores(event.id);
    result.fold(
        (failure) => emit(StudentScoresErrorState(message: failure.message)),
        (score) => emit(StudentScoresLoadedState(studentScores: score)));
  }

  FutureOr<void> _getStudentsScoresHandler(
      GetStudentScoresEvent event, Emitter<StudentScoresState> emit) async {
    emit(const GettingStudentsScoresState());
    final result = await _getStudentsScores();
    result.fold(
        (failure) => emit(StudentScoresErrorState(message: failure.message)),
        (scores) => emit(StudentsScoresLoadedState(studentScores: scores)));
  }
}
