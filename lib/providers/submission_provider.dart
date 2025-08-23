import 'package:flutter/material.dart';

class SubmissionProvider extends ChangeNotifier {
  String _signature = '';
  String _note = '';
  List<String> _images = [];
  bool _isSubmitting = false;
  bool _showSuccessMessage = false;

  String get signature => _signature;
  String get note => _note;
  List<String> get images => _images;
  bool get isSubmitting => _isSubmitting;
  bool get showSuccessMessage => _showSuccessMessage;

  bool get isSignatureValid => _signature.trim().isNotEmpty;

  void setSignature(String signature) {
    _signature = signature;
    notifyListeners();
  }

  void setNote(String note) {
    _note = note;
    notifyListeners();
  }

  void addImage(String imagePath) {
    _images.add(imagePath);
    notifyListeners();
  }

  void removeImage(String imagePath) {
    _images.remove(imagePath);
    notifyListeners();
  }

  void clearImages() {
    _images.clear();
    notifyListeners();
  }

  void setSubmitting(bool isSubmitting) {
    _isSubmitting = isSubmitting;
    notifyListeners();
  }

  void showSuccess() {
    _showSuccessMessage = true;
    notifyListeners();
  }

  void hideSuccess() {
    _showSuccessMessage = false;
    notifyListeners();
  }

  Future<bool> submitChecklist() async {
    if (!isSignatureValid) {
      return false;
    }

    setSubmitting(true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    setSubmitting(false);
    showSuccess();
    
    return true;
  }

  void resetForm() {
    _signature = '';
    _note = '';
    _images.clear();
    _showSuccessMessage = false;
    notifyListeners();
  }
}
