import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

class SaveWatchlistMovie {
  final MovieRepository movieRepository;

  SaveWatchlistMovie({required this.movieRepository});

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return movieRepository.saveWatchlist(movie);
  }
}
