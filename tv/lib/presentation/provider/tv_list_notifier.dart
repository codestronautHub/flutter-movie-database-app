import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_on_the_air_tvs.dart';
import '../../domain/usecases/get_popular_tvs.dart';
import '../../domain/usecases/get_top_Tq_tvs.dart';
import '../../domain/usecases/get_top_hq_tvs.dart';
import '../../domain/usecases/get_top_rated_tvs.dart';

class TvListNotifier extends ChangeNotifier {
  var _onTheAirTvs = <Tv>[];
  List<Tv> get onTheAirTvs => _onTheAirTvs;

  RequestState _onTheAirTvsState = RequestState.empty;
  RequestState get onTheAirTvsState => _onTheAirTvsState;

  List<Tv> _popularTvs = <Tv>[];
  List<Tv> get popularTvs => _popularTvs;

  RequestState _popularTvsState = RequestState.empty;
  RequestState get popularTvsState => _popularTvsState;

  List<Tv> _topRatedTvs = <Tv>[];
  List<Tv> get topRatedTvs => _topRatedTvs;

  RequestState _topRatedTvsState = RequestState.empty;
  RequestState get topRatedTvsState => _topRatedTvsState;

  List<Tv> _topTqTvs = <Tv>[];
  List<Tv> get topTqTvs => _topTqTvs;

  RequestState _topTqTvsState = RequestState.empty;
  RequestState get topTqTvsState => _topTqTvsState;

  List<Tv> _topHqTvs = <Tv>[];
  List<Tv> get topHqTvs => _topHqTvs;

  RequestState _topHqTvsState = RequestState.empty;
  RequestState get topHqTvsState => _topHqTvsState;

  String _message = '';
  String get message => _message;

  final GetOnTheAirTvs getOnTheAirTvs;
  final GetPopularTvs getPopularTvs;
  final GetTopRatedTvs getTopRatedTvs;
  final GetTopTqTvs getTopTqTvs;
  final GetTopHqTvs getTopHqTvs;

  TvListNotifier({
    required this.getOnTheAirTvs,
    required this.getPopularTvs,
    required this.getTopRatedTvs,
    required this.getTopTqTvs,
    required this.getTopHqTvs
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

   Future<void> fetchTopTqTvs() async {
    _topTqTvsState = RequestState.loading;
    notifyListeners();

    final result = await getTopTqTvs.execute();
    result.fold(
      (failure) {
        _topTqTvsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _topTqTvsState = RequestState.loaded;
        _topTqTvs = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopHqTvs() async {
    _topHqTvsState = RequestState.loading;
    notifyListeners();

    final result = await getTopHqTvs.execute();
    result.fold(
      (failure) {
        _topHqTvsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _topHqTvsState = RequestState.loaded;
        _topHqTvs = tvsData;
        notifyListeners();
      },
    );
  }
}
