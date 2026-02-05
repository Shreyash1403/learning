import 'package:equatable/equatable.dart';
import 'package:learning_2/modules/complaint/models/complaint_model.dart';

/// Full API response wrapper model
/// Uses Equatable for proper equality comparison (required for BLoC)
class ComplaintResponseModel extends Equatable {
  final int statusCode;
  final String message;
  final String apiResponseCode;
  final List<ComplaintModel> activeComplaints;
  final List<ComplaintModel> pastComplaints;
  final List<ComplaintModel> todaysComplaints;
  final int totalTodays;
  final int totalActive;
  final int totalPast;
  final int totalComplaints;

  const ComplaintResponseModel({
    required this.statusCode,
    required this.message,
    required this.apiResponseCode,
    required this.activeComplaints,
    required this.pastComplaints,
    required this.todaysComplaints,
    required this.totalTodays,
    required this.totalActive,
    required this.totalPast,
    required this.totalComplaints,
  });

  /// Factory constructor to parse full API response
  factory ComplaintResponseModel.fromJson(Map<String, dynamic> json) {
    return ComplaintResponseModel(
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
      apiResponseCode: json['api_response_code'] ?? '',
      activeComplaints:
          (json['active_complaints'] as List<dynamic>?)
              ?.map((item) => ComplaintModel.fromJson(item))
              .toList() ??
          [],
      pastComplaints:
          (json['past_complaints'] as List<dynamic>?)
              ?.map((item) => ComplaintModel.fromJson(item))
              .toList() ??
          [],
      todaysComplaints:
          (json['todays_complaints'] as List<dynamic>?)
              ?.map((item) => ComplaintModel.fromJson(item))
              .toList() ??
          [],
      totalTodays: json['total_todays'] ?? 0,
      totalActive: json['total_active'] ?? 0,
      totalPast: json['total_past'] ?? 0,
      totalComplaints: json['total_complaints'] ?? 0,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() => {
    'status_code': statusCode,
    'message': message,
    'api_response_code': apiResponseCode,
    'active_complaints': activeComplaints.map((e) => e.toJson()).toList(),
    'past_complaints': pastComplaints.map((e) => e.toJson()).toList(),
    'todays_complaints': todaysComplaints.map((e) => e.toJson()).toList(),
    'total_todays': totalTodays,
    'total_active': totalActive,
    'total_past': totalPast,
    'total_complaints': totalComplaints,
  };

  /// Create a copy with updated fields
  ComplaintResponseModel copyWith({
    int? statusCode,
    String? message,
    String? apiResponseCode,
    List<ComplaintModel>? activeComplaints,
    List<ComplaintModel>? pastComplaints,
    List<ComplaintModel>? todaysComplaints,
    int? totalTodays,
    int? totalActive,
    int? totalPast,
    int? totalComplaints,
  }) {
    return ComplaintResponseModel(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      apiResponseCode: apiResponseCode ?? this.apiResponseCode,
      activeComplaints: activeComplaints ?? this.activeComplaints,
      pastComplaints: pastComplaints ?? this.pastComplaints,
      todaysComplaints: todaysComplaints ?? this.todaysComplaints,
      totalTodays: totalTodays ?? this.totalTodays,
      totalActive: totalActive ?? this.totalActive,
      totalPast: totalPast ?? this.totalPast,
      totalComplaints: totalComplaints ?? this.totalComplaints,
    );
  }

  /// Equatable: List of properties to compare for equality
  @override
  List<Object?> get props => [
    statusCode,
    message,
    apiResponseCode,
    activeComplaints,
    pastComplaints,
    todaysComplaints,
    totalTodays,
    totalActive,
    totalPast,
    totalComplaints,
  ];
}
