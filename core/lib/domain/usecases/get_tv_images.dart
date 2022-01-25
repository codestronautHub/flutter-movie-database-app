import 'package:dartz/dartz.dart';
import '../../core.dart';
import '../entities/media_image.dart';
import '../repositories/tv_repository.dart';

class GetTvImages {
  final TvRepository repository;

  GetTvImages(this.repository);

  Future<Either<Failure, MediaImage>> execute(int id) {
    return repository.getTvImages(id);
  }
}
