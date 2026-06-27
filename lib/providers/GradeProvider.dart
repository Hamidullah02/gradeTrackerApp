import 'package:flutter/material.dart';
import '../models/subject.dart';

final List<Map<String, dynamic>> dummyData = [
  {'name': 'Mathematics', 'mark': 85.5},
  {'name': 'Physics', 'mark': 72.0},
  {'name': 'Chemistry', 'mark': 64.0},
  {'name': 'Biology', 'mark': 91.0},
];

class GradeProvider extends ChangeNotifier {
  final List<Subject> _subjects = [];
  bool _isDarkMode = false;

  List<Subject> get subjects => _subjects;
  bool get isDarkMode => _isDarkMode;

  GradeProvider() {
    loadDummyData();
  }

  void loadDummyData() {
    for (var subject in dummyData) {
      _subjects.add(
        Subject(
          name: subject['name'],
          mark: subject['mark'],
        ),
      );
    }
    notifyListeners();
  }

  void addSubject(String name, double mark) {
    _subjects.add(
      Subject(
        name: name,
        mark: mark,
      ),
    );
    notifyListeners();
  }

  void removeSubject(int index) {
    _subjects.removeAt(index);
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  double get averageMark {
    if (_subjects.isEmpty) return 0.0;
    double totalMarks = 0;
    for (var subject in _subjects) {
      totalMarks += subject.mark;
    }
    return totalMarks / _subjects.length;
  }

  List<Subject> get passingSubjects {
    return _subjects.where((subject) => subject.grade != 'F').toList();
  }

  List<String> get subjectNames {
    return _subjects.map((subject) => subject.name).toList();
  }

  String get overallGrade {
    if (_subjects.isEmpty) return 'N/A';
    double avg = averageMark;
    if (avg >= 80) return 'A';
    if (avg >= 65) return 'B';
    if (avg >= 50) return 'C';
    return 'F';
  }
}