import 'package:flutter/material.dart';
import 'package:gradetracker/providers/GradeProvider.dart';
import 'package:gradetracker/screens/addSubject.dart';
import 'package:gradetracker/screens/subjectList.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GradeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GradeProvider>(
      builder: (context, gradeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Grade Tracker',
          // home:  AddSubject(),
          home:  SubjectList(),

        );
      },
    );
  }
}
