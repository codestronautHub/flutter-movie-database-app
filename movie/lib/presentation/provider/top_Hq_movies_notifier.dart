import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_top_Hq_movies.dart';

class TopHqMoviesNotifier extends ChangeNotifier {
  final GetTopHqMovies getTopHqMovies;

  TopHqMoviesNotifier({required this.getTopHqMovies});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopHqMovies() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTopHqMovies.execute();

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
