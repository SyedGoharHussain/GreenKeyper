import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greenkeyper/providers/vehicle_provider.dart';
import 'package:greenkeyper/providers/checklist_provider.dart';
import 'package:greenkeyper/providers/auth_provider.dart';
import 'package:greenkeyper/widgets/reusable_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Consumer3<VehicleProvider, ChecklistProvider, AuthProvider>(
        builder: (context, vehicleProvider, checklistProvider, authProvider, child) {
          final currentUser = authProvider.currentUser;

          return Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFF00796B),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.amber[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.home,
                          color: Color(0xFF00796B),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Home',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Stack(
                        children: [
                          const Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 24,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      // Profile Button
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/edit-profile');
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.red[100],
                          child: Icon(
                            Icons.person,
                            color: Colors.red[700],
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Welcome Banner
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00796B), Color(0xFF00A28A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00796B).withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello ${currentUser?.name ?? 'User'},',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Welcome to Greenkeyper!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text('👋', style: TextStyle(fontSize: 24)),
                  ],
                ),
              ),

              // Information Cards
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        // First Row - Assigned Vehicles and Checklist Status
                        Row(
                          children: [
                            // Assigned Vehicles Card
                            Expanded(
                              child: _buildInfoCard(
                                icon: Icons.directions_boat,
                                title: 'Assigned Vehicles',
                                value: '03',
                                color: Colors.orange,
                                trailing: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Vehicle icons representing the 6 vehicles
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.grey[300],
                                      child: Icon(
                                        Icons.directions_boat,
                                        color: Colors.grey[600],
                                        size: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.red[100],
                                      child: Icon(
                                        Icons.directions_boat,
                                        color: Colors.red[700],
                                        size: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.grey[200],
                                          child: Icon(
                                            Icons.directions_boat,
                                            color: Colors.grey[600],
                                            size: 14,
                                          ),
                                        ),
                                        Positioned(
                                          right: -2,
                                          top: -2,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 4,
                                              vertical: 1,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.orange,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: const Text(
                                              '+3',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(width: 16),

                            // Checklist Status Card
                            Expanded(
                              child: _buildInfoCard(
                                icon: Icons.check_circle,
                                title: 'Checklist Status',
                                value: '',
                                color: Colors.transparent,
                                trailing: Column(
                                  children: [
                                    // Donut Chart
                                    SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Stack(
                                        children: [
                                          CircularProgressIndicator(
                                            value: 0.8,
                                            strokeWidth: 8,
                                            backgroundColor: Colors.orange[200],
                                            valueColor:
                                                const AlwaysStoppedAnimation<
                                                  Color
                                                >(Color(0xFF00796B)),
                                          ),
                                          Center(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Text(
                                                'Checked',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Legend
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF00796B),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Beginning of the day',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: Colors.orange[400],
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'End of the day',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Vehicle Fault Status Card
                        _buildInfoCard(
                          icon: Icons.build,
                          title: 'Vehicle Fault Status',
                          value: '',
                          color: Colors.transparent,
                          trailing: Column(
                            children: [
                              // Resolved
                              Row(
                                children: [
                                  const Text(
                                    'Resolved',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: 0.75,
                                      backgroundColor: Colors.grey[200],
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                            Color(0xFF00796B),
                                          ),
                                      minHeight: 8,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    '03',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Pending
                              Row(
                                children: [
                                  const Text(
                                    'Pending',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: 0.25,
                                      backgroundColor: Colors.grey[200],
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                            Colors.orange,
                                          ),
                                      minHeight: 8,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    '01',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),

              // Call to Action Button - Using Gradient Button
              Container(
                margin: const EdgeInsets.all(16),
                child: ReusableWidgets.gradientButton(
                  text: 'Proceed to checklist',
                  onPressed: () {
                    Navigator.pushNamed(context, '/assigned-vehicles');
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required Widget trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF00796B),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              if (value.isNotEmpty)
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          trailing,
        ],
      ),
    );
  }
}
