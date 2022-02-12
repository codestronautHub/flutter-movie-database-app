import 'package:core/domain/entities/media_image.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../repositories/movie_repository.dart';

class GetMovieImages {
  final MovieRepository repository;

  GetMovieImages(this.repository);

  Future<Either<Failure, MediaImage>> execute(int id) {
    return repository.getMovieImages(id);
  }
}
