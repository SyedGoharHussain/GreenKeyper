import 'package:flutter/material.dart';
import 'package:greenkeyper/routes.dart';
import 'package:greenkeyper/theme/colors.dart';
import 'package:greenkeyper/widgets/reusable_widgets.dart';

class ResetCodeScreen extends StatefulWidget {
  const ResetCodeScreen({super.key});

  @override
  State<ResetCodeScreen> createState() => _ResetCodeScreenState();
}

class _ResetCodeScreenState extends State<ResetCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _verifyCode() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    Navigator.pushNamed(context, Routes.newPassword);
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
                          "Reset Code",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.tealPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Please enter the code sent to your email",
                        style: TextStyle(fontSize: 16, color: Colors.black),
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
                      const TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: AppColors.tealPrimary,
                          ),
                          hintText: "abc@gmail.com",
                        ),
                      ),
                      const SizedBox(height: 15),

                      const Text(
                        "Enter Code",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.tealPrimary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _codeController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the verification code';
                          }
                          if (value.length != 6) {
                            return 'Code must be 6 digits';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.code,
                            color: AppColors.tealPrimary,
                          ),
                          hintText: "Enter the 6-digit code",
                        ),
                      ),
                      const SizedBox(height: 30),

                      ReusableWidgets.gradientButton(
                        text: "Continue",
                        onPressed: _verifyCode,
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
