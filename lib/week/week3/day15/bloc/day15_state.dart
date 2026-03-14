import 'package:equatable/equatable.dart';
import 'package:learning_2/week/week2/day11.dart';

abstract class Day15State extends Equatable {
  const Day15State();
  @override
  List<Object?> get props => [];
}

class TaskInitial extends Day15State {}

class TaskLoading extends Day15State {}

class TaskLoaded extends Day15State {
  final ProjectResponse projectResponse;
  const TaskLoaded({required this.projectResponse});
  @override
  List<Object?> get props => [projectResponse];
}

class TaskError extends Day15State {
  final String message;
  const TaskError({required this.message});
  @override
  List<Object?> get props => [message];
}
