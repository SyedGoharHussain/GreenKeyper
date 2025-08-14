import 'package:flutter/material.dart';
import 'package:greenkeyper/routes.dart';
import 'package:greenkeyper/theme/colors.dart';
import 'package:greenkeyper/widgets/reusable_widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submitSignup() async {
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
                          "Create your account",
                          subtitle: "Fill in your details to get started",
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Name Field
                      const Text(
                        "Full Name",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.tealPrimary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          if (value.length < 3) {
                            return 'Name must be at least 3 characters';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: AppColors.tealPrimary,
                          ),
                          hintText: "Enter your full name",
                        ),
                      ),
                      const SizedBox(height: 15),

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

                      // Phone Field
                      const Text(
                        "Contact",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.tealPrimary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (!RegExp(r'^[0-9]{10,}$').hasMatch(value)) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: AppColors.tealPrimary,
                          ),
                          hintText: "Enter your phone number",
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
                            return 'Please enter a password';
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
                      const SizedBox(height: 15),

                      // Confirm Password Field
                      const Text(
                        "Confirm Password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.tealPrimary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
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
                              _obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(
                                () => _obscureConfirmPassword =
                                    !_obscureConfirmPassword,
                              );
                            },
                          ),
                          hintText: "Confirm your password",
                        ),
                      ),
                      const SizedBox(height: 20),

                      ReusableWidgets.gradientButton(
                        text: "Sign up",
                        onPressed: _submitSignup,
                        isLoading: _isLoading,
                      ),
                      const SizedBox(height: 20),

                      ReusableWidgets.authFooter(
                        text: "Already have an account?",
                        actionText: "Login",
                        onAction: () =>
                            Navigator.pushNamed(context, Routes.login),
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
