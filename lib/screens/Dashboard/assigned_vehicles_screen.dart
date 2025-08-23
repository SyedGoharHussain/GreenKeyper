import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greenkeyper/providers/vehicle_provider.dart';
import 'package:greenkeyper/widgets/reusable_widgets.dart';

class AssignedVehiclesScreen extends StatefulWidget {
  const AssignedVehiclesScreen({super.key});

  @override
  State<AssignedVehiclesScreen> createState() => _AssignedVehiclesScreenState();
}

class _AssignedVehiclesScreenState extends State<AssignedVehiclesScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Consumer<VehicleProvider>(
        builder: (context, vehicleProvider, child) {
          return Column(
            children: [
              // Header
              AppHeader(
                title: 'Assigned Vehicles (${vehicleProvider.totalVehicles})',
                icon: Icons.directions_boat,
                onBackPressed: () => Navigator.pop(context),
              ),
              
              // Search Bar
              CustomSearchBar(
                placeholder: 'Search Vehicles',
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                  vehicleProvider.searchVehicles(query);
                },
              ),
              
              // Vehicle List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: vehicleProvider.vehicles.length,
                  itemBuilder: (context, index) {
                    final vehicle = vehicleProvider.vehicles[index];
                    
                    // Filter vehicles based on search query
                    if (_searchQuery.isNotEmpty &&
                        !vehicle.name.toLowerCase().contains(_searchQuery.toLowerCase()) &&
                        (vehicle.licensePlate == null ||
                         !vehicle.licensePlate!.toLowerCase().contains(_searchQuery.toLowerCase()))) {
                      return const SizedBox.shrink();
                    }
                    
                    return VehicleCard(
                      name: vehicle.name,
                      licensePlate: vehicle.licensePlate,
                      isSelected: vehicle.isSelected,
                      onTap: () {
                        vehicleProvider.selectVehicle(vehicle.id);
                        // Navigate to vehicle details or checklist
                        Navigator.pushNamed(context, '/checklist-time');
                      },
                    );
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
