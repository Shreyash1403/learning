import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_2/core/api/exceptions.dart';
import 'package:learning_2/week/week3/day15/bloc/day15_event.dart';
import 'package:learning_2/week/week3/day15/bloc/day15_state.dart';
import 'package:learning_2/week/week3/day15/repo.dart';

class Day15Bloc extends Bloc<Day15Event, Day15State> {
  final Repo repo;
  Day15Bloc({required this.repo}) : super(TaskInitial()) {
    on<FetchTaskEvent>(_onFetchTask);
  }
  Future<void> _onFetchTask(
    FetchTaskEvent event,
    Emitter<Day15State> emit,
  ) async {
    emit(TaskLoading());
    try {
      final response = await repo.fetchTask(
        locationId: event.locationId,
        verificationOf: event.verificationOf,
        fromDate: event.fromDate,
        toDate: event.toDate,
        page: event.page,
      );
      emit(TaskLoaded(projectResponse: response));
    } on SessionExpiredException catch (e) {
      emit(TaskError(message: e.message));
    } on ApiException catch (e) {
      emit(TaskError(message: e.message));
    } on NetworkException catch (e) {
      emit(TaskError(message: e.message));
    } catch (e) {
      emit(TaskError(message: e.toString()));
    }
  }
}
