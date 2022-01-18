import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/media_image.dart';
import 'package:core/domain/repositories/tv_repository.dart';

class GetTvImages {
  final TvRepository repository;

  GetTvImages(this.repository);

  Future<Either<Failure, MediaImage>> execute(int id) {
    return repository.getTvImages(id);
  }
}
