import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_top_rated_tvs.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class TopRatedTvsNotifier extends ChangeNotifier {
  final GetTopRatedTvs getTopRatedTvs;

  TopRatedTvsNotifier(this.getTopRatedTvs);

  List<Tv> _tvs = <Tv>[];
  List<Tv> get tvs => _tvs;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvs() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvs.execute();
    result.fold(
      (failure) {
        _state = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _state = RequestState.loaded;
        _tvs = tvsData;
        notifyListeners();
      },
    );
  }
}
