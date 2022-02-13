import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/usecases/get_tv_detail.dart';
import '../../domain/usecases/get_tv_recommendations.dart';
import '../../domain/usecases/get_tv_watchlist_status.dart';
import '../../domain/usecases/remove_watchlist_tv.dart';
import '../../domain/usecases/save_watchlist_tv.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetTvWatchlistStatus getWatchListStatus;
  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  late TvDetail _tv;
  TvDetail get tv => _tv;

  RequestState _tvState = RequestState.empty;
  RequestState get tvState => _tvState;

  List<Tv> _recommendations = [];
  List<Tv> get recommendations => _recommendations;

  RequestState _recommendationsState = RequestState.empty;
  RequestState get recommendationsState => _recommendationsState;

  String _message = '';
  String get message => _message;

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.loading;
    notifyListeners();

    final detailResult = await getTvDetail.execute(id);
    final recommendationsResult = await getTvRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _tvState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _recommendationsState = RequestState.loading;
        _tvState = RequestState.loaded;
        _tv = tv;
        notifyListeners();
        recommendationsResult.fold(
          (failure) {
            _recommendationsState = RequestState.error;
            _message = failure.message;
          },
          (tvs) {
            _recommendationsState = RequestState.loaded;
            _recommendations = tvs;
          },
        );
        notifyListeners();
      },
    );
  }

  Future<void> addToWatchlist(TvDetail tv) async {
    final result = await saveWatchlist.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(TvDetail tv) async {
    final result = await removeWatchlist.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedToWatchlist = result;
    notifyListeners();
  }
}
