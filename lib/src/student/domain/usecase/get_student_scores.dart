import 'package:students/core/typedef/typedef.dart';
import 'package:students/core/usecases/usecase.dart';
import 'package:students/src/student/domain/entities/student_scores.dart';
import 'package:students/src/student/domain/repos/student_scores_repository.dart';

class GetStudentScores extends UsecaseWithParams<StudentScores, String> {
  final StudentScoresRepository _repository;

  GetStudentScores({required StudentScoresRepository repository})
      : _repository = repository;

  @override
  ResultFuture<StudentScores> call(String params) async =>
      _repository.getScore(id: params);
}
