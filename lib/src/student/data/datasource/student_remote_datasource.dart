import 'package:students/src/student/domain/entities/student_scores.dart';

abstract class StudentRemoteDatasource {
  const StudentRemoteDatasource();
  Future createScore(
      {required String studentid,
      required int english,
      required int kiswahili,
      required int math,
      required int science,
      required int sstandcre});
  Future udpateScore({required String id, required StudentScores scores});
  Future deleteScore({required String id});
  Future<StudentScores> getScore({required String id});
  Future<List<StudentScores>> getScores();
}
