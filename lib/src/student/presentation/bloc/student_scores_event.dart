part of 'student_scores_bloc.dart';

sealed class StudentScoresEvent extends Equatable {
  const StudentScoresEvent();

  @override
  List<Object> get props => [];
}

class CreatingStudentScoreEvent extends StudentScoresEvent {
  final String studentid;
  final int english;
  final int kiswahili;
  final int math;
  final int science;
  final int sstandcre;

  const CreatingStudentScoreEvent(
      {required this.studentid,
      required this.english,
      required this.kiswahili,
      required this.math,
      required this.science,
      required this.sstandcre});

  @override
  List<Object> get props =>
      [studentid, english, kiswahili, math, science, sstandcre];
}

class UpdateStudentScoreEvent extends StudentScoresEvent {
  final StudentScores score;
  const UpdateStudentScoreEvent({required this.score});
}

class DeleteStudentScoreEvent extends StudentScoresEvent {
  final String id;
  const DeleteStudentScoreEvent({required this.id});
}

class GetStudentScoreEvent extends StudentScoresEvent {
  final String id;

  const GetStudentScoreEvent({required this.id});
}

class GetStudentScoresEvent extends StudentScoresEvent {
  const GetStudentScoresEvent();
}
