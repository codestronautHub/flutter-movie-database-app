import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_top20_chinese_movies.dart';

class Top20ChineseMoviesNotifier extends ChangeNotifier {
  final GetTop20ChineseMovies getTop20ChineseMovies;

  Top20ChineseMoviesNotifier({required this.getTop20ChineseMovies});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchTop20ChineseMovies() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTop20ChineseMovies.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (moviesData) {
        _movies = moviesData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
