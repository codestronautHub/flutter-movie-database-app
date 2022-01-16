import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  MdbContentType _state = MdbContentType.Movie;

  MdbContentType get state => _state;

  void setState(MdbContentType newState) {
    _state = newState;
    notifyListeners();
  }
}
