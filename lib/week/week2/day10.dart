import 'package:equatable/equatable.dart';
import 'package:learning_2/week/week2/day9.dart';

class Project extends Equatable {
  final String projectName;
  final List<Task> tasks;

  const Project({required this.projectName, required this.tasks});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectName: json["projectName"]?.toString() ?? "",
      tasks:
          (json['tasks'] as List<dynamic>?)
              ?.map((e) => Task.fromJson(e))
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [projectName, tasks];
}
