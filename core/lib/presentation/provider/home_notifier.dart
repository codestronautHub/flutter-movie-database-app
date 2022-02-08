import 'package:flutter/material.dart';
import '../../core.dart';

class HomeNotifier extends ChangeNotifier {
  MdbContentType _state = MdbContentType.movie;

  MdbContentType get state => _state;

  void setState(MdbContentType newState) {
    _state = newState;
    notifyListeners();
  }
}
