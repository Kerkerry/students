import 'package:flutter/material.dart';
import 'package:students/core/helper/logger_helper.dart';
import 'package:students/core/services/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:students/src/auth/domain/entities/user.dart';
import 'package:students/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:students/src/student/presentation/bloc/student_scores_bloc.dart';
import 'package:students/src/student/presentation/pages/student_score_page.dart';
import 'package:students/src/student/presentation/widgets/scores_input_field.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<StudentScoresBloc>())
      ],
      child: MaterialApp(
        title: 'Student Performance',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Students Reports'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void getUsers() {
    context.read<AuthBloc>().add(const GetUsersEvent());
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  // Student information
  final firstname = TextEditingController();
  final secondname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  // Scores
  final englishController = TextEditingController();
  final kiswahiliController = TextEditingController();
  final mathController = TextEditingController();
  final scienceController = TextEditingController();
  final sstandcreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is UserCreatedState) {
          getUsers();
        }

        if (state is UserDeletedState) {
          getUsers();
        }
        if (state is UserUpdatedState) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: state is AuthErrorState
              ? Center(
                  child: Text(state.message),
                )
              : state is GettingUserState
                  ? const Center(child: CircularProgressIndicator())
                  : state is UsersLoadedState
                      ? state.users.isEmpty
                          ? const Center(child: Text("There no users"))
                          : ListView.builder(
                              itemCount: state.users.length,
                              itemBuilder: (context, index) {
                                final User student = state.users[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 13, vertical: 10),
                                  child: ListTile(
                                    title: Text(
                                        "${student.firstname} ${student.secondname}"),
                                    subtitle: Text(student.email),
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => StudentScorePage(
                                                studentid: student.id,
                                                studentFullName:
                                                    "${student.firstname} ${student.secondname}"))),
                                    trailing: SizedBox(
                                      width: 145,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () => _createScore(
                                                context: context,
                                                stdid: student.id),
                                            icon: const Icon(Icons.add),
                                          ),
                                          IconButton(
                                            onPressed: () => _updateStudent(
                                                context: context,
                                                user: student),
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.green,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              context.read<AuthBloc>().add(
                                                  DeleteUserEvent(
                                                      id: student.id));
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                      : const SizedBox.shrink(),
          floatingActionButton: FloatingActionButton(
            onPressed: () async => await _createStudent(context: context),
            tooltip: 'Add user',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Future<void> _createScore(
      {required BuildContext context, required String stdid}) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Subjects Sores'),
          content: Form(
              child: Column(
            children: [
              ScoresInputField(
                  useNumberKeyboard: true,
                  inputController: englishController,
                  lableText: "English"),
              const SizedBox(height: 10),
              ScoresInputField(
                  useNumberKeyboard: true,
                  inputController: kiswahiliController,
                  lableText: "Kiswahili"),
              const SizedBox(height: 10),
              ScoresInputField(
                  useNumberKeyboard: true,
                  inputController: mathController,
                  lableText: "Mathematics"),
              const SizedBox(height: 10),
              ScoresInputField(
                  useNumberKeyboard: true,
                  inputController: scienceController,
                  lableText: "Science"),
              const SizedBox(height: 10),
              ScoresInputField(
                  useNumberKeyboard: true,
                  inputController: sstandcreController,
                  lableText: "SST and CRE"),
              const SizedBox(height: 10),
            ],
          )),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            BlocListener<StudentScoresBloc, StudentScoresState>(
              listener: (context, state) {
                if (state is StudentScoresCreatedState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Scores created")));
                }
              },
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Submit'),
                onPressed: () {
                  if (englishController.text.isNotEmpty &&
                      kiswahiliController.text.isNotEmpty &&
                      mathController.text.isNotEmpty &&
                      scienceController.text.isNotEmpty &&
                      sstandcreController.text.isNotEmpty) {
                    context.read<StudentScoresBloc>().add(
                        CreatingStudentScoreEvent(
                            studentid: stdid,
                            english: int.parse(englishController.text),
                            kiswahili: int.parse(kiswahiliController.text),
                            math: int.parse(mathController.text),
                            science: int.parse(scienceController.text),
                            sstandcre: int.parse(sstandcreController.text)));
                    Navigator.of(context).pop();
                    englishController.clear();
                    kiswahiliController.clear();
                    mathController.clear();
                    scienceController.clear();
                    sstandcreController.clear();
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _createStudent({required BuildContext context}) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        firstname.clear();
        secondname.clear();
        email.clear();
        password.clear();
        return AlertDialog(
          title: const Text('Create student'),
          content: Form(
              child: Column(
            children: [
              ScoresInputField(
                  useNumberKeyboard: false,
                  inputController: firstname,
                  lableText: "First name"),
              const SizedBox(height: 10),
              ScoresInputField(
                  useNumberKeyboard: false,
                  inputController: secondname,
                  lableText: "Second name"),
              const SizedBox(height: 10),
              ScoresInputField(
                  useNumberKeyboard: false,
                  inputController: email,
                  isemail: true,
                  lableText: "Email"),
              const SizedBox(height: 10),
              ScoresInputField(
                  useNumberKeyboard: false,
                  inputController: password,
                  ispassword: true,
                  lableText: "Password"),
              const SizedBox(height: 10)
            ],
          )),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Submit'),
              onPressed: () {
                if (firstname.text.isNotEmpty &&
                    secondname.text.isNotEmpty &&
                    email.text.isNotEmpty &&
                    password.text.isNotEmpty) {
                  context.read<AuthBloc>().add(CreatingUserEvent(
                      firstname: firstname.text.trim(),
                      secondname: secondname.text.trim(),
                      email: email.text.trim(),
                      password: password.text.trim()));
                  Navigator.of(context).pop();
                }
                logger.e("Not empty");
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateStudent(
      {required BuildContext context, required User user}) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        firstname.text = user.firstname;
        secondname.text = user.secondname;
        email.text = user.email;
        password.text = user.password;
        return AlertDialog(
          title: const Text('Create student'),
          content: Form(
              child: Column(
            children: [
              ScoresInputField(
                  useNumberKeyboard: false,
                  inputController: firstname,
                  lableText: "First name"),
              const SizedBox(height: 10),
              ScoresInputField(
                  useNumberKeyboard: false,
                  inputController: secondname,
                  lableText: "Second name"),
              const SizedBox(height: 10),
              ScoresInputField(
                  useNumberKeyboard: false,
                  inputController: email,
                  isemail: true,
                  lableText: "Email"),
              const SizedBox(height: 10),
              ScoresInputField(
                  useNumberKeyboard: false,
                  inputController: password,
                  ispassword: false,
                  lableText: "Password"),
              const SizedBox(height: 10)
            ],
          )),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Submit'),
              onPressed: () {
                final User newUser = User(
                    id: user.id,
                    firstname: firstname.text,
                    secondname: secondname.text,
                    email: email.text,
                    password: password.text);
                context.read<AuthBloc>().add(UpdateUserEvent(user: newUser));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
