import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_now_playing_movies.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/usecases/get_top20_chinese_movies.dart';
import '../../domain/usecases/get_top_Hq_movies.dart';
import '../../domain/usecases/get_top_rated_movies.dart';

class MovieListNotifier extends ChangeNotifier {
  var _nowPlayingMovies = <Movie>[];
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  RequestState _nowPlayingState = RequestState.empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularMovies = <Movie>[];
  List<Movie> get popularMovies => _popularMovies;

  RequestState _popularMoviesState = RequestState.empty;
  RequestState get popularMoviesState => _popularMoviesState;

  var _topRatedMovies = <Movie>[];
  List<Movie> get topRatedMovies => _topRatedMovies;

  RequestState _topRatedMoviesState = RequestState.empty;
  RequestState get topRatedMoviesState => _topRatedMoviesState;

  //////// add top chinese movies..////
  var _top20ChineseMovies = <Movie>[];
  List<Movie> get top20ChineseMovies => _top20ChineseMovies;

  RequestState _top20ChineseMoviesState = RequestState.empty;
  RequestState get top20ChineseMoviesState => _top20ChineseMoviesState;

  var _topHqMovies = <Movie>[];
  List<Movie> get topHqMovies => _topHqMovies;

  RequestState _topHqMoviesState = RequestState.empty;
  RequestState get topHqMoviesState => _topHqMoviesState;

  String _message = '';
  String get message => _message;

  MovieListNotifier(
      {required this.getNowPlayingMovies,
      required this.getPopularMovies,
      required this.getTopRatedMovies,
      required this.getTop20ChineseMovies,
      required this.getTopHqMovies
      });

  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;
  final GetTop20ChineseMovies getTop20ChineseMovies;
  final GetTopHqMovies getTopHqMovies;

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingState = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _nowPlayingState = RequestState.loaded;
        _nowPlayingMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularMovies() async {
    _popularMoviesState = RequestState.loading;
    notifyListeners();

    final result = await getPopularMovies.execute();
    result.fold(
      (failure) {
        _popularMoviesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _popularMoviesState = RequestState.loaded;
        _popularMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    _topRatedMoviesState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        _topRatedMoviesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _topRatedMoviesState = RequestState.loaded;
        _topRatedMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTop20ChineseMovies() async {
    _top20ChineseMoviesState = RequestState.loading;
    notifyListeners();

    final result = await getTop20ChineseMovies.execute();
    result.fold(
      (failure) {
        _top20ChineseMoviesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _top20ChineseMoviesState = RequestState.loaded;
        _top20ChineseMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopHqMovies() async {
    _topHqMoviesState = RequestState.loading;
    notifyListeners();

    final result = await getTopHqMovies.execute();
    result.fold(
      (failure) {
        _topHqMoviesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _topHqMoviesState = RequestState.loaded;
        _topHqMovies = moviesData;
        notifyListeners();
      },
    );
  }
}
