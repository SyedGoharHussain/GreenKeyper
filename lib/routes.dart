import 'package:flutter/material.dart';
import 'package:greenkeyper/screens/Auth_screens/forgot_password_screen.dart';
import 'package:greenkeyper/screens/Auth_screens/new_password_screen.dart';
import 'package:greenkeyper/screens/Auth_screens/reset_code_screen.dart';
import 'package:greenkeyper/screens/Auth_screens/login_screen.dart';
import 'package:greenkeyper/screens/Auth_screens/signup_screen.dart';

class Routes {
  static const login = '/login';
  static const signup = '/signup';
  static const forgotPassword = '/forgot-password';
  static const resetCode = '/reset-code';
  static const newPassword = '/new-password';

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
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}