import 'package:equatable/equatable.dart';

class Dummy extends Equatable {
  final String? paidBy;
  final String? date;
  final int currentPage;

  const Dummy({this.paidBy, this.date, required this.currentPage});

  factory Dummy.fromJson(Map<String, dynamic> json) {
    final rawDummy = (json['paid_by']?.toString() ?? "");
    final rawDate = json["date"]?.toString() ?? "";
    return Dummy(
      paidBy: rawDummy.isNotEmpty ? rawDummy : null,
      date: (rawDate.isNotEmpty && rawDate != "0000-00-00 00:00:00")
          ? rawDate
          : null,
      currentPage: int.tryParse(json["current_page"]?.toString() ?? "") ?? 0,
    );
  }

  @override
  List<Object?> get props => [paidBy, date, currentPage];
}
