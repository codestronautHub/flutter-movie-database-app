import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetTopHqMovies {
  final MovieRepository repository;

  GetTopHqMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopHqMovies();
  }
}
