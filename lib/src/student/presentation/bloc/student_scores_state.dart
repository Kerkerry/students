part of 'student_scores_bloc.dart';

sealed class StudentScoresState extends Equatable {
  const StudentScoresState();

  @override
  List<Object> get props => [];
}

final class StudentScoresInitial extends StudentScoresState {}

class CreatingStudentScoresState extends StudentScoresState {
  const CreatingStudentScoresState();
}

class StudentScoresCreatedState extends StudentScoresState {
  const StudentScoresCreatedState();
}

class GettingStudentsScoresState extends StudentScoresState {
  const GettingStudentsScoresState();
}

class StudentsScoresLoadedState extends StudentScoresState {
  final List<StudentScores> studentScores;

  const StudentsScoresLoadedState({required this.studentScores});

  @override
  List<String> get props =>
      studentScores.map((studentScore) => studentScore.id).toList();
}

class GettingStudentScoresState extends StudentScoresState {
  const GettingStudentScoresState();
}

class StudentScoresLoadedState extends StudentScoresState {
  final StudentScores studentScores;

  const StudentScoresLoadedState({required this.studentScores});

  @override
  List<String> get props => [studentScores.id];
}

class UpdatingStudentScoresState extends StudentScoresState {
  const UpdatingStudentScoresState();
}

class StudentScoresUpdatedState extends StudentScoresState {
  const StudentScoresUpdatedState();
}

class DeletingStudentScoresState extends StudentScoresState {
  const DeletingStudentScoresState();
}

class StudentScoresDeletedState extends StudentScoresState {
  const StudentScoresDeletedState();
}

class StudentScoresErrorState extends StudentScoresState {
  final String message;

  const StudentScoresErrorState({required this.message});

  @override
  List<String> get props => [message];
}
