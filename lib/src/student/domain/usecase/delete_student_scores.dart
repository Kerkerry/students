import 'package:students/core/typedef/typedef.dart';
import 'package:students/core/usecases/usecase.dart';
import 'package:students/src/student/domain/repos/student_scores_repository.dart';

class DeleteStudentScores extends UsecaseWithParams<void, String> {
  final StudentScoresRepository _repository;

  DeleteStudentScores({required StudentScoresRepository repository})
      : _repository = repository;
  @override
  ResultFuture<void> call(String params) async =>
      _repository.deleteScore(id: params);
}
