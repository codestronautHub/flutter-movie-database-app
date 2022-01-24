import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import '../../domain/usecases/search_tvs.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTvs searchTvs;

  TvSearchNotifier({required this.searchTvs});

  List<Tv> _searchResult = [];
  List<Tv> get searchResult => _searchResult;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchTvs.execute(query);
    result.fold(
      (failure) {
        _state = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _state = RequestState.loaded;
        _searchResult = data;
        notifyListeners();
      },
    );
  }
}
