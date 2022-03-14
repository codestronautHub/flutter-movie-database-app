import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetTop20ChineseMovies {
  final MovieRepository repository;

  GetTop20ChineseMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTop20ChineseMovies();
  }
}
