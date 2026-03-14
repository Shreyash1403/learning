import 'package:learning_2/week/week2/day11.dart';
import 'package:learning_2/week/week3/day15/day15.dart';

class Repo {
  final ApiService apiService = ApiService();

  Future<ProjectResponse> fetchTask({
    required String locationId,
    required int verificationOf,
    required String fromDate,
    required String toDate,
    required int page,
  }) async {
    return await apiService.fetchTasks(
      locationId: locationId,
      verificationOf: verificationOf,
      fromDate: fromDate,
      toDate: toDate,
      page: page,
    );
  }
}
