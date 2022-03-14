import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetTopAcMovies {
  final MovieRepository repository;

  GetTopAcMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopAcMovies();
  }
}
