import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_top_Ac_movies.dart';

class TopAcMoviesNotifier extends ChangeNotifier {
  final GetTopAcMovies getTopAcMovies;

  TopAcMoviesNotifier({required this.getTopAcMovies});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopAcMovies() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTopAcMovies.execute();

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
