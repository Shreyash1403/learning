import 'package:flutter/material.dart';
import 'package:learning_2/core/routes/app_routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Add MultiBlocProvider in Phase 4 when BLoCs are created
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.complaintOverview,
      onUnknownRoute: AppRoutes.unknownRoute,
    );
  }
}
