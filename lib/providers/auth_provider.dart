import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String? profileImage;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
  });
}

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isAuthenticated = false;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;

  // Simulate login
  Future<bool> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo purposes, accept any login
    if (email.isNotEmpty && password.isNotEmpty) {
      _currentUser = User(
        id: '1',
        name: email.split('@')[0], // Use email prefix as name
        email: email,
        profileImage: null,
      );
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  // Logout
  void logout() {
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  // Update user profile
  void updateProfile({String? name, String? email}) {
    if (_currentUser != null) {
      _currentUser = User(
        id: _currentUser!.id,
        name: name ?? _currentUser!.name,
        email: email ?? _currentUser!.email,
        profileImage: _currentUser!.profileImage,
      );
      notifyListeners();
    }
  }
}
