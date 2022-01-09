import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/media_image.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTvImages {
  final TvRepository repository;

  GetTvImages(this.repository);

  Future<Either<Failure, MediaImage>> execute(int id) {
    return repository.getTvImages(id);
  }
}
