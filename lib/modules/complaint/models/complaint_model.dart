import 'package:equatable/equatable.dart';

/// Full model for a complaint item with all API fields
/// Uses Equatable for proper equality comparison (required for BLoC)
class ComplaintModel extends Equatable {
  final String complainId;
  final String complainCategoryId;
  final String categoryName;
  final String complainTitle;
  final String complainDescription;
  final int complainStatus;
  final String statusText;
  final LaunchedBy? launchedBy;
  final String launchedOn;
  final String dateOfIncidence;
  final List<String> photoUrls;
  final List<String> videoUrls;
  final List<ViewHistory> viewHistory;

  const ComplaintModel({
    required this.complainId,
    required this.complainCategoryId,
    required this.categoryName,
    required this.complainTitle,
    required this.complainDescription,
    required this.complainStatus,
    required this.statusText,
    this.launchedBy,
    required this.launchedOn,
    required this.dateOfIncidence,
    required this.photoUrls,
    required this.videoUrls,
    required this.viewHistory,
  });

  /// Factory constructor to parse JSON from API
  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      complainId: json['complain_id'] ?? '',
      complainCategoryId: json['complain_category_id'] ?? '',
      categoryName: json['category_name'] ?? '',
      complainTitle: json['complain_title'] ?? '',
      complainDescription: json['complain_description'] ?? '',
      complainStatus: json['complain_status'] ?? 0,
      statusText: json['status_text'] ?? '',
      launchedBy: json['launched_by'] != null
          ? LaunchedBy.fromJson(json['launched_by'])
          : null,
      launchedOn: json['launched_on'] ?? '',
      dateOfIncidence: json['date_of_incidence'] ?? '',
      photoUrls:
          (json['photo_urls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      videoUrls:
          (json['video_urls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      viewHistory:
          (json['view_history'] as List<dynamic>?)
              ?.map((e) => ViewHistory.fromJson(e))
              .toList() ??
          [],
    );
  }

  /// Convert model to JSON for API requests
  Map<String, dynamic> toJson() => {
    'complain_id': complainId,
    'complain_category_id': complainCategoryId,
    'category_name': categoryName,
    'complain_title': complainTitle,
    'complain_description': complainDescription,
    'complain_status': complainStatus,
    'status_text': statusText,
    'launched_by': launchedBy?.toJson(),
    'launched_on': launchedOn,
    'date_of_incidence': dateOfIncidence,
    'photo_urls': photoUrls,
    'video_urls': videoUrls,
    'view_history': viewHistory.map((e) => e.toJson()).toList(),
  };

  /// Create a copy with updated fields (useful for state management)
  ComplaintModel copyWith({
    String? complainId,
    String? complainCategoryId,
    String? categoryName,
    String? complainTitle,
    String? complainDescription,
    int? complainStatus,
    String? statusText,
    LaunchedBy? launchedBy,
    String? launchedOn,
    String? dateOfIncidence,
    List<String>? photoUrls,
    List<String>? videoUrls,
    List<ViewHistory>? viewHistory,
  }) {
    return ComplaintModel(
      complainId: complainId ?? this.complainId,
      complainCategoryId: complainCategoryId ?? this.complainCategoryId,
      categoryName: categoryName ?? this.categoryName,
      complainTitle: complainTitle ?? this.complainTitle,
      complainDescription: complainDescription ?? this.complainDescription,
      complainStatus: complainStatus ?? this.complainStatus,
      statusText: statusText ?? this.statusText,
      launchedBy: launchedBy ?? this.launchedBy,
      launchedOn: launchedOn ?? this.launchedOn,
      dateOfIncidence: dateOfIncidence ?? this.dateOfIncidence,
      photoUrls: photoUrls ?? this.photoUrls,
      videoUrls: videoUrls ?? this.videoUrls,
      viewHistory: viewHistory ?? this.viewHistory,
    );
  }

  /// Equatable: List of properties to compare for equality
  @override
  List<Object?> get props => [
    complainId,
    complainCategoryId,
    categoryName,
    complainTitle,
    complainDescription,
    complainStatus,
    statusText,
    launchedBy,
    launchedOn,
    dateOfIncidence,
    photoUrls,
    videoUrls,
    viewHistory,
  ];
}

/// Model for the tenant who launched the complaint
class LaunchedBy extends Equatable {
  final String id;
  final String name;

  const LaunchedBy({required this.id, required this.name});

  factory LaunchedBy.fromJson(Map<String, dynamic> json) {
    return LaunchedBy(id: json['id'] ?? '', name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  LaunchedBy copyWith({String? id, String? name}) {
    return LaunchedBy(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  List<Object?> get props => [id, name];
}

/// Model for complaint status history
class ViewHistory extends Equatable {
  final int status;
  final String remarks;
  final String updatedOn;
  final String? updatedBy;

  const ViewHistory({
    required this.status,
    required this.remarks,
    required this.updatedOn,
    this.updatedBy,
  });

  factory ViewHistory.fromJson(Map<String, dynamic> json) {
    return ViewHistory(
      status: json['status'] ?? 0,
      remarks: json['remarks'] ?? '',
      updatedOn: json['updated_on'] ?? '',
      updatedBy: json['updated_by'],
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'remarks': remarks,
    'updated_on': updatedOn,
    'updated_by': updatedBy,
  };

  ViewHistory copyWith({
    int? status,
    String? remarks,
    String? updatedOn,
    String? updatedBy,
  }) {
    return ViewHistory(
      status: status ?? this.status,
      remarks: remarks ?? this.remarks,
      updatedOn: updatedOn ?? this.updatedOn,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }

  @override
  List<Object?> get props => [status, remarks, updatedOn, updatedBy];
}
