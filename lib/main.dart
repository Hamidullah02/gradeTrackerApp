import 'package:flutter/material.dart';
import 'package:gradetracker/providers/GradeProvider.dart';
import 'package:gradetracker/screens/addSubject.dart';
import 'package:gradetracker/screens/subjectList.dart';
import 'package:gradetracker/screens/summary.dart';
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
          home: const Home(),
        );
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _screens = const [
    AddSubject(),
    SubjectList(),
    SummaryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final gradeProvider = Provider.of<GradeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Grade Tracker"),
        actions: [
          IconButton(
            icon: Icon(
              gradeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              gradeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Summary',
          ),
        ],
      ),
    );
  }
}
