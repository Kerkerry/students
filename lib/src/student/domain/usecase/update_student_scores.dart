import 'package:students/core/typedef/typedef.dart';
import 'package:students/core/usecases/usecase.dart';
import 'package:students/src/student/domain/entities/student_scores.dart';
import 'package:students/src/student/domain/repos/student_scores_repository.dart';

class UpdateStudentScores extends UsecaseWithParams<void, StudentScores> {
  final StudentScoresRepository _repository;

  UpdateStudentScores({required StudentScoresRepository repository})
      : _repository = repository;

  @override
  ResultFuture<void> call(StudentScores params) async =>
      _repository.udpateScore(id: params.id, scores: params);
}
