import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:flutter/material.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTvs searchTvs;

  TvSearchNotifier({required this.searchTvs});

  List<Tv> _searchResult = [];
  List<Tv> get searchResult => _searchResult;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvs.execute(query);
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _state = RequestState.Loaded;
        _searchResult = data;
        notifyListeners();
      },
    );
  }
}
