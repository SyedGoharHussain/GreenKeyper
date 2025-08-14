import 'package:flutter/material.dart';
import 'package:greenkeyper/routes.dart';
import 'package:greenkeyper/theme/colors.dart';
import 'package:greenkeyper/widgets/reusable_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submitResetRequest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    Navigator.pushNamed(context, Routes.resetCode);
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
                      const Center(
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.tealPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                        "Please enter your email to request a password reset",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      ),
                      
                      const SizedBox(height: 30),

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
                      const SizedBox(height: 30),

                      ReusableWidgets.gradientButton(
                        text: "Send Code",
                        onPressed: _submitResetRequest,
                        isLoading: _isLoading,
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
