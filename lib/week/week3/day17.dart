import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learning_2/week/week2/day9.dart';

class Day17 extends StatelessWidget {
  Day17({super.key});

  final List<Task> tasks = [
    Task(
      taskId: "1",
      title: "Test API",
      description: "Test API on postman, check all validations",
      status: 0,
      isUrgent: true,
      tags: ["Pending", "Working"],
    ),
    Task(
      taskId: "2",
      title: "Integrate API",
      description: "Integrate API on postman, check all validations",
      status: 1,
      isUrgent: false,
      tags: ["Not Working", "Working"],
    ),
    Task(
      taskId: "3",
      title: "Build UI",
      description: "Figma design and built UI",
      status: 0,
      isUrgent: true,
      tags: ["Under Working", "Working"],
    ),
    Task(
      taskId: "4",
      title: "Debugging",
      description: "Test API on postman, check all validations",
      status: 2,
      isUrgent: true,
      tags: ["Pending", "Working"],
    ),
    Task(
      taskId: "4",
      title: "Merge Code",
      description: "Test API on postman, check all validations",
      status: 3,
      isUrgent: true,
      tags: ["Pending", "Working"],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(tasks[index].title),
                subtitle: Text(tasks[index].description),
                trailing: Text(tasks[index].status.toString()),
              ),
            );
          },
        ),
      ),
    );
  }
}
