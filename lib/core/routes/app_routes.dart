import 'package:flutter/material.dart';
import 'package:learning_2/modules/complaint/screens/complaint_overview.dart';

class AppRoutes {
  static const String complaintOverview = '/complaint-overview';
  static const String complaintAdd = '/complaint-add';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case complaintOverview:
        return MaterialPageRoute(
          builder: (context) => const ComplaintOverviewScreen(),
        );
      case complaintAdd:
        if (settings.arguments is String) {
          final id = settings.arguments as String;
          return MaterialPageRoute(
            // builder: (context) => ComplaintAddScreen(complaintId: id),
            builder: (context) => Container(), // Placeholder
          );
        }
      default:
        return null;
    }
    return null;
  }

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) =>
          const Scaffold(body: Center(child: Text('Unknown Route'))),
    );
  }
}
