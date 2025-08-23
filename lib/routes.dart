import 'package:flutter/material.dart';
import 'package:greenkeyper/screens/Auth_screens/forgot_password_screen.dart';
import 'package:greenkeyper/screens/Auth_screens/new_password_screen.dart';
import 'package:greenkeyper/screens/Auth_screens/reset_code_screen.dart';
import 'package:greenkeyper/screens/Auth_screens/login_screen.dart';
import 'package:greenkeyper/screens/Auth_screens/signup_screen.dart';
import 'package:greenkeyper/screens/Dashboard/home_screen.dart';
import 'package:greenkeyper/screens/Dashboard/checklist_screen.dart';
import 'package:greenkeyper/screens/Dashboard/edit_profile_screen.dart';
import 'package:greenkeyper/screens/Dashboard/assigned_vehicles_screen.dart';
import 'package:greenkeyper/screens/Dashboard/checklist_time_screen.dart';
import 'package:greenkeyper/screens/Dashboard/submission_screen.dart';

class Routes {
  static const login = '/login';
  static const signup = '/signup';
  static const forgotPassword = '/forgot-password';
  static const resetCode = '/reset-code';
  static const newPassword = '/new-password';
  static const home = '/home';
  static const assignedVehicles = '/assigned-vehicles';
  static const checklistTime = '/checklist-time';
  static const checklist = '/checklist';
  static const submission = '/submission';
  static const editProfile = '/edit-profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case resetCode:
        return MaterialPageRoute(builder: (_) => const ResetCodeScreen());
      case newPassword:
        return MaterialPageRoute(builder: (_) => const NewPasswordScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case assignedVehicles:
        return MaterialPageRoute(builder: (_) => const AssignedVehiclesScreen());
      case checklistTime:
        return MaterialPageRoute(builder: (_) => const ChecklistTimeScreen());
      case checklist:
        return MaterialPageRoute(
          builder: (_) => ChecklistScreen(
            checklistType: settings.arguments as String,
          ),
        );
      case submission:
        return MaterialPageRoute(builder: (_) => const SubmissionScreen());
      case editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
