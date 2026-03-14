import 'package:equatable/equatable.dart';
import 'package:learning_2/week/week2/day10.dart';

class ProjectResponse extends Equatable {
  final String message;
  final int errorCode;
  final PaginationData paginationData;
  final List<Project> projects;

  const ProjectResponse({
    required this.message,
    required this.errorCode,
    required this.paginationData,
    required this.projects,
  });

  factory ProjectResponse.fromJson(Map<String, dynamic> json) {
    return ProjectResponse(
      message: json["message"]?.toString() ?? "",
      errorCode: int.tryParse(json["errorCode"]?.toString() ?? "") ?? 0,
      paginationData: json["paginationData"] != null
          ? PaginationData.fromJson(json["paginationData"])
          : const PaginationData(),
      projects:
          (json["projects"] as List<dynamic>?)
              ?.map((e) => Project.fromJson(e))
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [message, errorCode, paginationData, projects];
}

class PaginationData extends Equatable {
  final int currentPage;
  final int totalPages;
  final int totalRecords;
  final int perPage;

  const PaginationData({
    this.currentPage = 0,
    this.totalPages = 0,
    this.totalRecords = 0,
    this.perPage = 0,
  });

  factory PaginationData.fromJson(Map<String, dynamic> json) {
    return PaginationData(
      currentPage: int.tryParse(json["currentPage"]?.toString() ?? "") ?? 0,
      totalPages: int.tryParse(json["totalPages"]?.toString() ?? "") ?? 0,
      totalRecords: int.tryParse(json["totalRecords"]?.toString() ?? "") ?? 0,
      perPage: int.tryParse(json["perPage"]?.toString() ?? "") ?? 0,
    );
  }

  @override
  List<Object?> get props => [currentPage, totalPages, totalRecords, perPage];
}
