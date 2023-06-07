import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class EmailModel extends ChangeNotifier {
  bool _isEmailCorrect = true;

  bool get isEmailCorrect => _isEmailCorrect;

  void updateEmail(String email) {
    _isEmailCorrect = isEmail(email);
    notifyListeners();
  }
}
