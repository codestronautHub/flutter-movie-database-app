import 'package:flutter/material.dart';
import '../../core.dart';

class HomeNotifier extends ChangeNotifier {
  GeneralContentType _state = GeneralContentType.movie;

  GeneralContentType get state => _state;

  void setState(GeneralContentType newState) {
    _state = newState;
    notifyListeners();
  }
}
