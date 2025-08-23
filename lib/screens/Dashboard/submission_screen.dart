import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:ui';
import 'package:greenkeyper/providers/submission_provider.dart';
import 'package:greenkeyper/widgets/reusable_widgets.dart';

class SubmissionScreen extends StatefulWidget {
  const SubmissionScreen({super.key});

  @override
  State<SubmissionScreen> createState() => _SubmissionScreenState();
}

class _SubmissionScreenState extends State<SubmissionScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 80,
      );

      if (image != null) {
        context.read<SubmissionProvider>().addImage(image.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Consumer<SubmissionProvider>(
        builder: (context, submissionProvider, child) {
          return Stack(
            children: [
              Column(
                children: [
                  // Header
                  AppHeader(
                    title: 'Submission',
                    icon: Icons.check_circle_outline,
                    onBackPressed: () => Navigator.pop(context),
                  ),

                  // Main Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Add Signature Section
                          _buildSection(
                            icon: Icons.gesture,
                            title: 'Add Signature',
                            isRequired: true,
                            child: Container(
                              width: double.infinity,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: TextField(
                                onChanged: submissionProvider.setSignature,
                                maxLines: null,
                                expands: true,
                                decoration: InputDecoration(
                                  hintText: 'Add Signature here',
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(16),
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Add Note Section
                          _buildSection(
                            icon: Icons.description,
                            title: 'Add Note',
                            isRequired: false,
                            child: Container(
                              width: double.infinity,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: TextField(
                                onChanged: submissionProvider.setNote,
                                maxLines: null,
                                expands: true,
                                decoration: InputDecoration(
                                  hintText: 'Enter Defect details here...',
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(16),
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Add Images Section
                          _buildSection(
                            icon: Icons.landscape,
                            title: 'Add Images',
                            isRequired: false,
                            child: Column(
                              children: [
                                // Upload Button
                                GestureDetector(
                                  onTap: () => _pickImage(context),
                                  child: Container(
                                    width: double.infinity,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.grey[300]!,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.cloud_upload,
                                          color: Colors.blue[400],
                                          size: 40,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Click to upload image',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Image Preview (if any)
                                if (submissionProvider.images.isNotEmpty)
                                  SizedBox(
                                    height: 120,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          submissionProvider.images.length,
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                right: 12,
                                              ),
                                              width: 120,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                image: DecorationImage(
                                                  image: FileImage(
                                                    File(
                                                      submissionProvider
                                                          .images[index],
                                                    ),
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 4,
                                              right: 16,
                                              child: GestureDetector(
                                                onTap: () {
                                                  submissionProvider
                                                      .removeImage(
                                                        submissionProvider
                                                            .images[index],
                                                      );
                                                },
                                                child: Container(
                                                  width: 24,
                                                  height: 24,
                                                  decoration:
                                                      const BoxDecoration(
                                                        color: Colors.red,
                                                        shape: BoxShape.circle,
                                                      ),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Submit Button (Fixed at bottom) - Using Gradient Button
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    child: ReusableWidgets.gradientButton(
                      text: 'Submit',
                      onPressed: submissionProvider.isSignatureValid
                          ? () => submissionProvider.submitChecklist()
                          : () {},
                    ),
                  ),
                ),
              ),

              // Blur Background Overlay (like new password screen)
              if (submissionProvider.showSuccessMessage)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(color: Colors.transparent),
                  ),
                ),

              // Success Toast Banner (Exact Design Match)
              if (submissionProvider.showSuccessMessage)
                Positioned(
                  top: 100, // Position below header
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3CD), // Light yellow background
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Large black checkmark icon
                        const Icon(
                          Icons.check_circle,
                          color: Colors.black,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        // Success text
                        const Expanded(
                          child: Text(
                            'Checklist submitted !',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        // Close button (X)
                        GestureDetector(
                          onTap: () {
                            submissionProvider.hideSuccess();
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required bool isRequired,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFF00796B), size: 24),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              isRequired ? '(Required)' : '(Optional)',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}
