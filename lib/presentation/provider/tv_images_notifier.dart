import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/media_image.dart';
import 'package:ditonton/domain/usecases/get_tv_images.dart';
import 'package:flutter/material.dart';

class TvImagesNotifier extends ChangeNotifier {
  final GetTvImages getTvImages;

  TvImagesNotifier({required this.getTvImages});

  late MediaImage _tvImages;
  MediaImage get tvImages => _tvImages;

  RequestState _tvImagesState = RequestState.Empty;
  RequestState get tvImagesState => _tvImagesState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvImages(int id) async {
    _tvImagesState = RequestState.Loading;
    notifyListeners();

    final result = await getTvImages.execute(id);
    result.fold(
      (failure) {
        _tvImagesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvImages) {
        _tvImagesState = RequestState.Loaded;
        _tvImages = tvImages;
        notifyListeners();
      },
    );
  }
}
