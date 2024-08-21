import 'package:equatable/equatable.dart';
import 'package:students/core/typedef/typedef.dart';
import 'package:students/core/usecases/usecase.dart';
import 'package:students/src/student/domain/repos/student_scores_repository.dart';

class CreateStudentScores extends UsecaseWithParams<void, StudentScoresParams> {
  final StudentScoresRepository _repository;

  CreateStudentScores({required StudentScoresRepository repository})
      : _repository = repository;

  @override
  ResultFuture<void> call(StudentScoresParams params) async =>
      _repository.createScore(
          studentid: params.studentid,
          english: params.english,
          kiswahili: params.kiswahili,
          math: params.math,
          science: params.science,
          sstandcre: params.sstandcre);
}

class StudentScoresParams extends Equatable {
  final String studentid;
  final int english;
  final int kiswahili;
  final int math;
  final int science;
  final int sstandcre;

  const StudentScoresParams({
    required this.studentid,
    required this.english,
    required this.kiswahili,
    required this.math,
    required this.science,
    required this.sstandcre,
  });

  @override
  List<Object?> get props =>
      [studentid, english, kiswahili, math, science, sstandcre];

  const StudentScoresParams.empty()
      : this(
            studentid: "66be62a5f4a154598b7b15f3",
            english: 74,
            kiswahili: 69,
            math: 98,
            science: 87,
            sstandcre: 80);
}
