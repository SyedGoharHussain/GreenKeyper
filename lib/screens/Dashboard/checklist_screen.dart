import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greenkeyper/providers/checklist_provider.dart';
import 'package:greenkeyper/widgets/reusable_widgets.dart';

class ChecklistScreen extends StatefulWidget {
  final String checklistType;

  const ChecklistScreen({
    super.key,
    required this.checklistType,
  });

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  @override
  void initState() {
    super.initState();
    // Set the checklist type when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChecklistProvider>().setChecklistType(widget.checklistType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Consumer<ChecklistProvider>(
        builder: (context, checklistProvider, child) {
          return Column(
            children: [
              // Header
              AppHeader(
                title: 'Checklist (${checklistProvider.totalItems})',
                icon: Icons.checklist,
                onBackPressed: () => Navigator.pop(context),
              ),
              
              // Progress Bar - Exact design from image
              Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: checklistProvider.progressPercentage / 100,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00796B)),
                            minHeight: 12,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '${checklistProvider.progressPercentage.toInt()}%',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Checklist Items
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: checklistProvider.currentItems.length,
                  itemBuilder: (context, index) {
                    final item = checklistProvider.currentItems[index];
                    return ChecklistItemCard(
                      description: item.description,
                      itemNumber: index + 1,
                      isCompleted: item.isCompleted,
                      isFlagged: item.isFlagged,
                      onCheckboxTap: () {
                        checklistProvider.toggleItemCompletion(item.id);
                      },
                      onFlagTap: () {
                        checklistProvider.toggleItemFlag(item.id);
                      },
                    );
                  },
                ),
              ),
              
              // Next Button - Using Gradient Button
              Container(
                margin: const EdgeInsets.all(16),
                child: ReusableWidgets.gradientButton(
                  text: 'Next',
                  onPressed: () {
                    // Navigate to submission screen
                    Navigator.pushNamed(context, '/submission');
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
