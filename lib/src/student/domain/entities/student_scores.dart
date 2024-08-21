import 'package:equatable/equatable.dart';

class StudentScores extends Equatable {
  final String id;
  final String studentid;
  final int english;
  final int kiswahili;
  final int math;
  final int science;
  final int sstandcre;

  const StudentScores(
      {required this.id,
      required this.studentid,
      required this.english,
      required this.kiswahili,
      required this.math,
      required this.science,
      required this.sstandcre});
  @override
  List<Object> get props =>
      [id, studentid, english, kiswahili, math, science, sstandcre];
}
