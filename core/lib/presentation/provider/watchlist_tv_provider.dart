import 'package:flutter/material.dart';

import '../../core.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_watchlist_tvs.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  final GetWatchlistTvs getWatchlistTvs;

  WatchlistTvNotifier({required this.getWatchlistTvs});

  var _watchlistTvs = <Tv>[];
  List<Tv> get watchlistTvs => _watchlistTvs;

  var _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistTvs() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistTvs.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (watchlistTvs) {
        _watchlistState = RequestState.loaded;
        _watchlistTvs = watchlistTvs;
        notifyListeners();
      },
    );
  }
}
