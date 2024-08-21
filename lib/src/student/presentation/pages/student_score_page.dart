import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:students/src/student/data/models/student_scores_model.dart';
import 'package:students/src/student/presentation/bloc/student_scores_bloc.dart';

class StudentScorePage extends StatefulWidget {
  const StudentScorePage(
      {super.key, required this.studentid, required this.studentFullName});
  final String studentid, studentFullName;

  @override
  State<StudentScorePage> createState() => _StudentScorePageState();
}

class _StudentScorePageState extends State<StudentScorePage> {
  void getScores() {
    context
        .read<StudentScoresBloc>()
        .add(GetStudentScoreEvent(id: widget.studentid));
  }

  @override
  void initState() {
    getScores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentScoresBloc, StudentScoresState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text("${widget.studentFullName} scores"),
        ),
        body: state is StudentScoresErrorState
            ? Center(
                child: Text(state.message.substring(0, 15) == "FormatException"
                    ? "There are scores for this student"
                    : state.message),
              )
            : state is GettingStudentScoresState
                ? const Center(child: CircularProgressIndicator())
                : state is StudentScoresLoadedState
                    ? Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          border: TableBorder.all(),
                          children: [
                            const TableRow(children: [
                              TableCell(child: Text("Subject")),
                              TableCell(child: Text("Score %")),
                            ]),
                            TableRow(children: [
                              const TableCell(child: Text("English")),
                              TableCell(
                                  child:
                                      Text("${state.studentScores.english}")),
                            ]),
                            TableRow(children: [
                              const TableCell(child: Text("Kiswahili")),
                              TableCell(
                                  child:
                                      Text("${state.studentScores.kiswahili}")),
                            ]),
                            TableRow(children: [
                              const TableCell(child: Text("Mathematics")),
                              TableCell(
                                  child: Text("${state.studentScores.math}")),
                            ]),
                            TableRow(children: [
                              const TableCell(child: Text("Science")),
                              TableCell(
                                  child:
                                      Text("${state.studentScores.science}")),
                            ]),
                            TableRow(children: [
                              const TableCell(child: Text("SST and CRE")),
                              TableCell(
                                  child:
                                      Text("${state.studentScores.sstandcre}")),
                            ]),
                            TableRow(children: [
                              const TableCell(child: Text("Total")),
                              TableCell(
                                  child: Text(
                                      "${StudentScoresModel(id: state.studentScores.id, studentid: state.studentScores.studentid, english: state.studentScores.english, kiswahili: state.studentScores.kiswahili, math: state.studentScores.math, science: state.studentScores.science, sstandcre: state.studentScores.sstandcre).totalMarks()} out of 500 marks")),
                            ]),
                            TableRow(children: [
                              const TableCell(child: Text("Grade")),
                              TableCell(
                                  child: Text(StudentScoresModel(
                                          id: state.studentScores.id,
                                          studentid:
                                              state.studentScores.studentid,
                                          english: state.studentScores.english,
                                          kiswahili:
                                              state.studentScores.kiswahili,
                                          math: state.studentScores.math,
                                          science: state.studentScores.science,
                                          sstandcre:
                                              state.studentScores.sstandcre)
                                      .grade())),
                            ]),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
      );
    });
  }
}
