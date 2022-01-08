import 'package:flutter/material.dart';

enum SearchFilter { movie, tv }

class SearchFilterNotifier extends ChangeNotifier {
  SearchFilter _filter = SearchFilter.movie;
  SearchFilter get filter => _filter;

  SearchFilter _currentFilter = SearchFilter.movie;
  SearchFilter get curentFilter => _currentFilter;

  void setFilter(SearchFilter newValue) {
    _currentFilter = _filter;
    _filter = newValue;
    notifyListeners();
  }
}
