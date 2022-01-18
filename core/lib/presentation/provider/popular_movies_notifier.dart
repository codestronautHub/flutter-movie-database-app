import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

class PopularMoviesNotifier extends ChangeNotifier {
  final GetPopularMovies getPopularMovies;

  PopularMoviesNotifier(this.getPopularMovies);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularMovies() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPopularMovies.execute();

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
