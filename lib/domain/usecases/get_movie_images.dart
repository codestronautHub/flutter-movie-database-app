import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/media_image.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetMovieImages {
  final MovieRepository repository;

  GetMovieImages(this.repository);

  Future<Either<Failure, MediaImage>> execute(int id) {
    return repository.getMovieImages(id);
  }
}
