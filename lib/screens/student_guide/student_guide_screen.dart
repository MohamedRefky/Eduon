import 'package:flutter/material.dart';

class StudentGuideScreen extends StatelessWidget {
  const StudentGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        title: 'Understand your academic year',
        subtitle:
            'Review the timeline, milestones, and what is expected from you.',
      ),
      (
        title: 'Plan your courses',
        subtitle:
            'Track prerequisites early and balance your semester workload.',
      ),
      (
        title: 'Build strong study habits',
        subtitle:
            'Set a weekly routine and revise consistently before deadlines.',
      ),
      (
        title: 'Ask for help early',
        subtitle:
            'Use office hours, teaching assistants, and classmates when stuck.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Student Guide')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                item.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(item.subtitle),
              ),
            ),
          );
        },
      ),
    );
  }
}
