import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_on_the_air_tvs.dart';
import 'package:core/domain/usecases/get_popular_tvs.dart';
import 'package:core/domain/usecases/get_top_rated_tvs.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class TvListNotifier extends ChangeNotifier {
  var _onTheAirTvs = <Tv>[];
  List<Tv> get onTheAirTvs => _onTheAirTvs;

  RequestState _onTheAirTvsState = RequestState.empty;
  RequestState get onTheAirTvsState => _onTheAirTvsState;

  var _popularTvs = <Tv>[];
  List<Tv> get popularTvs => _popularTvs;

  RequestState _popularTvsState = RequestState.empty;
  RequestState get popularTvsState => _popularTvsState;

  var _topRatedTvs = <Tv>[];
  List<Tv> get topRatedTvs => _topRatedTvs;

  RequestState _topRatedTvsState = RequestState.empty;
  RequestState get topRatedTvsState => _topRatedTvsState;

  String _message = '';
  String get message => _message;

  final GetOnTheAirTvs getOnTheAirTvs;
  final GetPopularTvs getPopularTvs;
  final GetTopRatedTvs getTopRatedTvs;

  TvListNotifier({
    required this.getOnTheAirTvs,
    required this.getPopularTvs,
    required this.getTopRatedTvs,
  });

  Future<void> fetchOnTheAirTvs() async {
    _onTheAirTvsState = RequestState.loading;
    notifyListeners();

    final result = await getOnTheAirTvs.execute();
    result.fold(
      (failure) {
        _onTheAirTvsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _onTheAirTvsState = RequestState.loaded;
        _onTheAirTvs = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvs() async {
    _popularTvsState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvs.execute();
    result.fold(
      (failure) {
        _popularTvsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _popularTvsState = RequestState.loaded;
        _popularTvs = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvs() async {
    _topRatedTvsState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvs.execute();
    result.fold(
      (failure) {
        _topRatedTvsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _topRatedTvsState = RequestState.loaded;
        _topRatedTvs = tvsData;
        notifyListeners();
      },
    );
  }
}
