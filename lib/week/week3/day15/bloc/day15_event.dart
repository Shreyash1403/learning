import 'package:equatable/equatable.dart';

class Day15Event extends Equatable {
  const Day15Event();
  @override
  List<Object?> get props => [];
}

class FetchTaskEvent extends Day15Event {
  final String locationId;
  final int verificationOf;
  final String fromDate;
  final String toDate;
  final int page;

  const FetchTaskEvent({
    required this.locationId,
    required this.verificationOf,
    required this.fromDate,
    required this.toDate,
    required this.page,
  });

  @override
  List<Object?> get props => [
    locationId,
    verificationOf,
    fromDate,
    toDate,
    page,
  ];
}
