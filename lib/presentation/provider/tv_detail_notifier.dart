import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:flutter/material.dart';

class TvDetailNotifier extends ChangeNotifier {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecommendations,
  });

  late TvDetail _tv;
  TvDetail get tv => _tv;

  RequestState _tvState = RequestState.Empty;
  RequestState get tvState => _tvState;

  List<Tv> _tvRecommendations = [];
  List<Tv> get tvRecommendations => _tvRecommendations;

  RequestState _recommendationsState = RequestState.Empty;
  RequestState get recommendationsState => _recommendationsState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvDetail.execute(id);
    final recommendationsResult = await getTvRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _recommendationsState = RequestState.Loading;
        _tvState = RequestState.Loaded;
        _tv = tv;
        notifyListeners();
        recommendationsResult.fold(
          (failure) {
            _recommendationsState = RequestState.Error;
            _message = failure.message;
          },
          (tvs) {
            _recommendationsState = RequestState.Loaded;
            _tvRecommendations = tvs;
          },
        );
        notifyListeners();
      },
    );
  }
}
