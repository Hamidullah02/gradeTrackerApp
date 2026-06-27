import 'package:flutter/material.dart';
import 'package:gradetracker/providers/GradeProvider.dart';
import 'package:provider/provider.dart';

class AddSubject extends StatefulWidget {
  const AddSubject({super.key});

  @override
  State<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _markController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _markController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final mark = double.parse(_markController.text);

      Provider.of<GradeProvider>(context, listen: false).addSubject(name, mark);

      _nameController.clear();
      _markController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Subject added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Add Subject",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Subject Name',
                    hintText: 'e.g. Mathematics',
                    prefixIcon: Icon(Icons.book),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a subject name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _markController,
                  decoration: const InputDecoration(
                    labelText: 'Subject Mark',
                    hintText: '0 - 100',
                    prefixIcon: Icon(Icons.percent),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a mark';
                    }
                    final mark = double.tryParse(value);
                    if (mark == null) {
                      return 'Please enter a valid number';
                    }
                    if (mark < 0 || mark > 100) {
                      return 'Mark must be between 0 and 100';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text("Add Subject"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}