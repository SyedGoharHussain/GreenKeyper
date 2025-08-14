import 'package:flutter/material.dart';
import 'package:greenkeyper/routes.dart';
import 'package:greenkeyper/theme/colors.dart';
import 'package:greenkeyper/widgets/reusable_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/bg.png",
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Transform.translate(
              offset: const Offset(0, -60),
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ReusableWidgets.authHeader(
                          "Welcome to GreenKeyper!",
                          subtitle: "Sign in to continue",
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Email Field
                      const Text(
                        "Email",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.tealPrimary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: AppColors.tealPrimary,
                          ),
                          hintText: "Enter your email",
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Password Field
                      const Text(
                        "Password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.tealPrimary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColors.tealPrimary,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(
                                () => _obscurePassword = !_obscurePassword,
                              );
                            },
                          ),
                          hintText: "Enter your password",
                        ),
                      ),
                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            Routes.forgotPassword,
                          ),
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: AppColors.tealPrimary),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      ReusableWidgets.gradientButton(
                        text: "Login",
                        onPressed: _submitLogin,
                        isLoading: _isLoading,
                      ),
                      const SizedBox(height: 20),

                      ReusableWidgets.authFooter(
                        text: "Don't have an account?",
                        actionText: "Sign up",
                        onAction: () =>
                            Navigator.pushNamed(context, Routes.signup),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
