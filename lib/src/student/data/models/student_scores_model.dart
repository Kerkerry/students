import 'dart:convert';

import 'package:students/core/typedef/typedef.dart';
import 'package:students/src/student/domain/entities/student_scores.dart';

class StudentScoresModel extends StudentScores {
  const StudentScoresModel(
      {required super.id,
      required super.studentid,
      required super.english,
      required super.kiswahili,
      required super.math,
      required super.science,
      required super.sstandcre});

  StudentScoresModel.fromMap(DataMap map)
      : this(
            id: map['_id'],
            studentid: map['studentid'],
            english: map['english'],
            kiswahili: map['kiswahili'],
            math: map['math'],
            science: map['science'],
            sstandcre: map['sstandcre']);
  factory StudentScoresModel.fromJson(String score) =>
      StudentScoresModel.fromMap(jsonDecode(score) as DataMap);

  StudentScoresModel copyWith(
      {String? id,
      String? studentid,
      int? english,
      int? kiswahili,
      int? math,
      int? science,
      int? sstandcre}) {
    return StudentScoresModel(
        id: id ?? this.id,
        studentid: studentid ?? this.studentid,
        english: english ?? this.english,
        kiswahili: kiswahili ?? this.kiswahili,
        math: math ?? this.math,
        science: science ?? this.science,
        sstandcre: sstandcre ?? this.sstandcre);
  }

  DataMap toMpa() {
    return {
      'id': id,
      'studentid': studentid,
      'english': english,
      'kiswahili': kiswahili,
      'math': math,
      'science': science,
      'sstandcre': sstandcre
    };
  }

  String toJson() => jsonEncode(toMpa());

  int totalMarks() {
    return english + kiswahili + math + science + sstandcre;
  }

  String grade() {
    double average = totalMarks() / 5;
    switch (average) {
      case >= 90 && < 100:
        return "A";
      case >= 80 && < 90:
        return "A-";
      case >= 70 && < 80:
        return "B+";
      case >= 60 && < 70:
        return "B";
      case >= 50 && < 60:
        return "B-";
      case >= 40 && < 50:
        return "C+";
      case >= 0 && < 40:
        return "F";
      default:
        return "Error";
    }
  }
}
