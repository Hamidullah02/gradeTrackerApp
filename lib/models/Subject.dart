class Subject {
  String name;
  late double _mark;

  Subject({required this.name, required double mark}) {
    _mark = mark;
  }

  double get mark => _mark;

  String get grade {
    if (_mark >= 80) return 'A';
    if (_mark >= 65) return 'B';
    if (_mark >= 50) return 'C';
    return 'F';
  }
}