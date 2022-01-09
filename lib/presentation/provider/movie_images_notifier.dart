import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/image.dart';
import 'package:ditonton/domain/usecases/get_movie_images.dart';
import 'package:flutter/material.dart' hide Image;

class MovieImagesNotifier extends ChangeNotifier {
  final GetMovieImages getMovieImages;

  MovieImagesNotifier({required this.getMovieImages});

  late Image _movieImages;
  Image get movieImages => _movieImages;

  RequestState _movieImagesState = RequestState.Empty;
  RequestState get movieImagesState => _movieImagesState;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieImages(int id) async {
    _movieImagesState = RequestState.Loading;
    notifyListeners();

    final result = await getMovieImages.execute(id);
    result.fold(
      (failure) {
        _movieImagesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (movieImages) {
        _movieImagesState = RequestState.Loaded;
        _movieImages = movieImages;
        notifyListeners();
      },
    );
  }
}
