import 'package:flutter/material.dart';

class Vehicle {
  final String id;
  final String name;
  final String? licensePlate;
  final bool isSelected;

  Vehicle({
    required this.id,
    required this.name,
    this.licensePlate,
    this.isSelected = false,
  });

  Vehicle copyWith({
    String? id,
    String? name,
    String? licensePlate,
    bool? isSelected,
  }) {
    return Vehicle(
      id: id ?? this.id,
      name: name ?? this.name,
      licensePlate: licensePlate ?? this.licensePlate,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class VehicleProvider extends ChangeNotifier {
  List<Vehicle> _vehicles = [
    Vehicle(id: '1', name: 'Nostalgia'),
    Vehicle(id: '2', name: 'Ocean Whisper', isSelected: true),
    Vehicle(id: '3', name: 'Silver Horizon'),
    Vehicle(id: '4', name: 'Honda Civic', licensePlate: 'ABC 9832'),
    Vehicle(id: '5', name: 'Suzuki Cultus', licensePlate: 'BKX 2245'),
    Vehicle(id: '6', name: 'Suzuki Alto', licensePlate: 'MEP 4521'),
  ];

  List<Vehicle> get vehicles => _vehicles;
  
  int get totalVehicles => _vehicles.length;
  
  Vehicle? get selectedVehicle => _vehicles.firstWhere(
    (vehicle) => vehicle.isSelected,
    orElse: () => _vehicles.first,
  );

  void selectVehicle(String vehicleId) {
    _vehicles = _vehicles.map((vehicle) {
      return vehicle.copyWith(
        isSelected: vehicle.id == vehicleId,
      );
    }).toList();
    notifyListeners();
  }

  void searchVehicles(String query) {
    // Implementation for search functionality
    notifyListeners();
  }
}
