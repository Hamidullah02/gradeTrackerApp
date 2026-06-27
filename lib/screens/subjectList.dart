import 'package:flutter/material.dart';
import 'package:gradetracker/models/subject.dart';
import 'package:gradetracker/providers/GradeProvider.dart';
import 'package:gradetracker/themes/app_themes.dart';
import 'package:provider/provider.dart';

class SubjectList extends StatelessWidget {
  const SubjectList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GradeProvider>(
      builder: (context, gradeProvider, child) {
        final subjects = gradeProvider.subjects;

        if (subjects.isEmpty) {
          return const Center(child: Text("No Subjects"));
        }
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Subjects",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    final subject = subjects[index];
                    return Dismissible(
                      key: Key(subject.name + index.toString()),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        gradeProvider.removeSubject(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${subject.name} deleted'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                      child: _SubjectCard(subject: subject),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final Subject subject;

  const _SubjectCard({required this.subject});

  @override
  Widget build(BuildContext context) {
    final Color gradeColor = AppTheme.getGradeColor(subject.grade);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        border: Border.all(
          color: Theme.of(context).dividerTheme.color ?? Colors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subject.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    subject.mark.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "/100",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(width: 12),
              CircleAvatar(
                backgroundColor: Theme.of(context).cardTheme.color,
                radius: 26,
                child: CircleAvatar(
                  backgroundColor: gradeColor.withOpacity(0.2),
                  radius: 25,
                  child: Text(
                    subject.grade,
                    style: TextStyle(
                      color: gradeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}