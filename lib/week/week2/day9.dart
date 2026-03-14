import 'package:equatable/equatable.dart';
import 'package:learning_2/week/week2/day8.dart';

class Task extends Equatable {
  // ──────────────────────────────────────────────
  // FIELDS
  // ──────────────────────────────────────────────

  // Non-nullable (always show) → use ?? in fromJson
  final String taskId;
  final String title;
  final String description;
  final int status;
  final bool isUrgent;
  final List<String> tags;

  // Nullable (hide section if null) → don't use ?? in fromJson
  final String? assignedTo;
  final Employee? employee;

  // ──────────────────────────────────────────────
  // CONSTRUCTOR
  // ──────────────────────────────────────────────

  const Task({
    required this.taskId,
    required this.title,
    required this.description,
    required this.status,
    required this.isUrgent,
    required this.tags,
    this.assignedTo, // nullable → not required
    this.employee, // nullable → not required
  });

  // ──────────────────────────────────────────────
  // FROM JSON
  // ──────────────────────────────────────────────
  // Rule 1: String (non-nullable)  → json['key']?.toString() ?? ''
  // Rule 2: int (non-nullable)     → int.tryParse(json['key']?.toString() ?? '') ?? 0
  // Rule 3: bool (non-nullable)    → json['key'] ?? false
  // Rule 4: String? (nullable)     → json['key']?.toString()  (NO ?? — let null stay null)
  // Rule 5: List<String>           → (json['key'] as List<dynamic>?)?.map(...).toList() ?? []
  // Rule 6: Object? (nullable)     → json['key'] != null ? Object.fromJson(...) : null

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      // Rule 1: String always show
      taskId: json['taskId']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',

      // Rule 2: int always show
      status: int.tryParse(json['status']?.toString() ?? '') ?? 0,

      // Rule 3: bool always show
      isUrgent: json['isUrgent'] ?? false,

      // Rule 4: String? — let null be null
      assignedTo: json['assignedTo']?.toString(),

      // Rule 5: List<String> — safe parsing with .map()
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
          [],

      // Rule 6: Object? — check null before parsing
      employee: json['employee'] != null
          ? Employee.fromJson(json['employee'])
          : null,
    );
  }

  // ──────────────────────────────────────────────
  // TO JSON
  // ──────────────────────────────────────────────

  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'title': title,
      'description': description,
      'status': status,
      'isUrgent': isUrgent,
      'tags': tags,
      'assignedTo': assignedTo,
      'employee': employee?.toJson(), // use ?. because employee could be null
    };
  }

  // ──────────────────────────────────────────────
  // COPY WITH
  // ──────────────────────────────────────────────
  // copyWith = "give me a copy of this object, but change SOME fields"
  // Why? Because fields are final — you can't change them directly.
  // So you create a NEW object with the changed fields.

  Task copyWith({
    String? taskId,
    String? title,
    String? description,
    int? status,
    bool? isUrgent,
    List<String>? tags,
    String? assignedTo,
    Employee? employee,
  }) {
    return Task(
      taskId: taskId ?? this.taskId, // use new value OR keep old
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      isUrgent: isUrgent ?? this.isUrgent,
      tags: tags ?? this.tags,
      assignedTo: assignedTo ?? this.assignedTo,
      employee: employee ?? this.employee,
    );
  }

  // ──────────────────────────────────────────────
  // EQUATABLE PROPS
  // ──────────────────────────────────────────────

  @override
  List<Object?> get props => [
    taskId,
    title,
    description,
    status,
    isUrgent,
    tags,
    assignedTo,
    employee,
  ];
}
