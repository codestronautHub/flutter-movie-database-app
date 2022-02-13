import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/media_image.dart';
import '../../domain/usecases/get_tv_images.dart';

class TvImagesNotifier extends ChangeNotifier {
  final GetTvImages getTvImages;

  TvImagesNotifier({required this.getTvImages});

  late MediaImage _tvImages;
  MediaImage get tvImages => _tvImages;

  RequestState _tvImagesState = RequestState.empty;
  RequestState get tvImagesState => _tvImagesState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvImages(int id) async {
    _tvImagesState = RequestState.loading;
    notifyListeners();

    final result = await getTvImages.execute(id);
    result.fold(
      (failure) {
        _tvImagesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvImages) {
        _tvImagesState = RequestState.loaded;
        _tvImages = tvImages;
        notifyListeners();
      },
    );
  }
}
