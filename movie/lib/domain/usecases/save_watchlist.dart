import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

class SaveWatchlist {
  final MovieRepository movieRepository;

  SaveWatchlist({required this.movieRepository});

  Future<Either<Failure, String>> executeMovie(MovieDetail movie) {
    return movieRepository.saveWatchlist(movie);
  }
}
