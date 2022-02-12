import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

class RemoveWatchlist {
  final MovieRepository movieRepository;

  RemoveWatchlist({required this.movieRepository});

  Future<Either<Failure, String>> executeMovie(MovieDetail movie) {
    return movieRepository.removeWatchlist(movie);
  }
}
