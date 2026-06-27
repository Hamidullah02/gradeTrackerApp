import 'package:flutter/material.dart';
import 'package:gradetracker/providers/GradeProvider.dart';
import 'package:gradetracker/themes/app_themes.dart';
import 'package:provider/provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GradeProvider>(
      builder: (context, gradeProvider, child) {
        final subjects = gradeProvider.subjects;
        final totalSubjects = subjects.length;
        final avgMark = gradeProvider.averageMark;
        final overallGrade = gradeProvider.overallGrade;
        final passingCount = gradeProvider.passingSubjects.length;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  "Academic Summary",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Theme.of(context).dividerTheme.color ?? Colors.grey,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0,2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppTheme.getGradeBackgroundColor(overallGrade),
                          radius: 53,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).cardTheme.color,
                            radius: 45,
                            child: Text(
                              overallGrade,
                              style: TextStyle(
                                color: AppTheme.getGradeColor(overallGrade),
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Overall Grade",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          avgMark > 0 ? avgMark.toStringAsFixed(1) : 'N/A',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        icon: Icons.menu_book,
                        label: "Total Subjects",
                        value: "$totalSubjects",
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _SummaryCard(
                        icon: Icons.show_chart,
                        label: "Avg Marks",
                        value: avgMark > 0 ? avgMark.toStringAsFixed(1) : 'N/A',
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        icon: Icons.check_circle,
                        label: "Passing",
                        value: "$passingCount",
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _SummaryCard(
                        icon: Icons.cancel,
                        label: "Failing",
                        value: "${totalSubjects - passingCount}",
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "All Subjects",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        if (subjects.isEmpty)
                          const Text("No subjects added yet")
                        else
                          ...subjects.map((subject) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    subject.name,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        subject.mark.toStringAsFixed(1),
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppTheme.getGradeBackgroundColor(subject.grade),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          subject.grade,
                                          style: TextStyle(
                                            color: AppTheme.getGradeColor(subject.grade),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}