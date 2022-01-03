import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  HomePageState _state = HomePageState.Movie;
  HomePageState get state => _state;
  void setState(HomePageState newState) {
    _state = newState;
    notifyListeners();
  }
}
