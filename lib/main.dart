import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greenkeyper/routes.dart';
import 'package:greenkeyper/theme/app_theme.dart';
import 'package:greenkeyper/providers/vehicle_provider.dart';
import 'package:greenkeyper/providers/checklist_provider.dart';
import 'package:greenkeyper/providers/submission_provider.dart';
import 'package:greenkeyper/providers/auth_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => VehicleProvider()),
        ChangeNotifierProvider(create: (_) => ChecklistProvider()),
        ChangeNotifierProvider(create: (_) => SubmissionProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: Routes.login,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
