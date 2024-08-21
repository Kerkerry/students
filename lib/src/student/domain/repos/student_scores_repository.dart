import 'package:students/core/typedef/typedef.dart';
import 'package:students/src/student/domain/entities/student_scores.dart';

abstract class StudentScoresRepository {
  const StudentScoresRepository();

  ResultVoid createScore(
      {required String studentid,
      required int english,
      required int kiswahili,
      required int math,
      required int science,
      required int sstandcre});
  ResultVoid udpateScore({required String id, required StudentScores scores});
  ResultVoid deleteScore({required String id});
  ResultFuture<StudentScores> getScore({required String id});
  ResultFuture<List<StudentScores>> getScores();
}
