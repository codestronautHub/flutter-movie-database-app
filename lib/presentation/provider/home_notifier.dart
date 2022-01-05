import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  ContentType _state = ContentType.Movie;
  ContentType get state => _state;
  void setState(ContentType newState) {
    _state = newState;
    notifyListeners();
  }
}
