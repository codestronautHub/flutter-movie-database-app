import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_top_Tq_tvs.dart';
import '../../domain/usecases/get_top_ac_tvs.dart';
import '../../domain/usecases/get_top_rated_tvs.dart';

class TopAcTvsNotifier extends ChangeNotifier {
  final GetTopAcTvs getTopAcTvs;

  TopAcTvsNotifier(this.getTopAcTvs);

  List<Tv> _tvs = <Tv>[];
  List<Tv> get tvs => _tvs;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopAcTvs() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTopAcTvs.execute();
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