import 'package:students/core/typedef/typedef.dart';
import 'package:students/core/usecases/usecase.dart';
import 'package:students/src/student/domain/entities/student_scores.dart';
import 'package:students/src/student/domain/repos/student_scores_repository.dart';

class GetStudentsScores extends UsecaseWithoutParams<List<StudentScores>> {
  final StudentScoresRepository _repository;

  GetStudentsScores({required StudentScoresRepository repository})
      : _repository = repository;
  @override
  ResultFuture<List<StudentScores>> call() async => _repository.getScores();
}
