import 'package:flutter/material.dart';

import '../../core.dart';
import '../../domain/entities/media_image.dart';
import '../../domain/usecases/get_movie_images.dart';

class MovieImagesNotifier extends ChangeNotifier {
  final GetMovieImages getMovieImages;

  MovieImagesNotifier({required this.getMovieImages});

  late MediaImage _movieImages;
  MediaImage get movieImages => _movieImages;

  RequestState _movieImagesState = RequestState.empty;
  RequestState get movieImagesState => _movieImagesState;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieImages(int id) async {
    _movieImagesState = RequestState.loading;
    notifyListeners();

    final result = await getMovieImages.execute(id);
    result.fold(
      (failure) {
        _movieImagesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (movieImages) {
        _movieImagesState = RequestState.loaded;
        _movieImages = movieImages;
        notifyListeners();
      },
    );
  }
}
