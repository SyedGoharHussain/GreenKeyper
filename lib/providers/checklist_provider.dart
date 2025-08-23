import 'package:flutter/material.dart';

class ChecklistItem {
  final String id;
  final String description;
  final bool isCompleted;
  final bool isFlagged;

  ChecklistItem({
    required this.id,
    required this.description,
    this.isCompleted = false,
    this.isFlagged = false,
  });

  ChecklistItem copyWith({
    String? id,
    String? description,
    bool? isCompleted,
    bool? isFlagged,
  }) {
    return ChecklistItem(
      id: id ?? this.id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isFlagged: isFlagged ?? this.isFlagged,
    );
  }
}

class ChecklistProvider extends ChangeNotifier {
  List<ChecklistItem> _beginningOfDayItems = [
    ChecklistItem(id: '1', description: 'Place Dock/Deck Mats at Nostalgia.', isCompleted: true),
    ChecklistItem(id: '2', description: 'Switch the Shore Power Dock Station Breakers right to "off."', isCompleted: true),
    ChecklistItem(id: '3', description: 'Remove the Shore Power Cord & store properly on the Shore Power Dock Station.', isCompleted: true),
    ChecklistItem(id: '4', description: 'Rotate all Three (3) Battery Selectors to "on" with the (1,1,2) Configuration.'),
    ChecklistItem(id: '5', description: 'Store all Instrument/Stereo Covers properly on the top shelf of the Cabin'),
    ChecklistItem(id: '6', description: 'Switch "Air/Cooler Pump", "Cabin Air" and "Helm Air" Breakers left to "off."'),
    ChecklistItem(id: '7', description: 'Rinse Nostalgia with fresh water.'),
    ChecklistItem(id: '8', description: 'Switch "Air/Cooler Pump", "Cabin Air" and "Helm Air" Breakers left to "off."'),
  ];

  List<ChecklistItem> _endOfDayItems = [];

  String _selectedChecklistType = 'beginning';

  List<ChecklistItem> get currentItems => _selectedChecklistType == 'beginning' 
      ? _beginningOfDayItems 
      : _endOfDayItems;

  String get selectedChecklistType => _selectedChecklistType;

  int get totalItems => currentItems.length;

  int get completedItems => currentItems.where((item) => item.isCompleted).length;

  double get progressPercentage => totalItems > 0 ? (completedItems / totalItems) * 100 : 0;

  void toggleItemCompletion(String itemId) {
    final items = _selectedChecklistType == 'beginning' 
        ? _beginningOfDayItems 
        : _endOfDayItems;
    
    final index = items.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      items[index] = items[index].copyWith(
        isCompleted: !items[index].isCompleted,
      );
      notifyListeners();
    }
  }

  void toggleItemFlag(String itemId) {
    final items = _selectedChecklistType == 'beginning' 
        ? _beginningOfDayItems 
        : _endOfDayItems;
    
    final index = items.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      items[index] = items[index].copyWith(
        isFlagged: !items[index].isFlagged,
      );
      notifyListeners();
    }
  }

  void setChecklistType(String type) {
    _selectedChecklistType = type;
    notifyListeners();
  }

  void resetChecklist() {
    _beginningOfDayItems = _beginningOfDayItems.map((item) {
      return item.copyWith(isCompleted: false, isFlagged: false);
    }).toList();
    _endOfDayItems = _endOfDayItems.map((item) {
      return item.copyWith(isCompleted: false, isFlagged: false);
    }).toList();
    notifyListeners();
  }
}
