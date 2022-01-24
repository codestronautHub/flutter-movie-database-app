import 'package:dartz/dartz.dart';
import '../../core.dart';
import '../entities/movie_detail.dart';
import '../entities/tv_detail.dart';
import '../repositories/movie_repository.dart';
import '../repositories/tv_repository.dart';

class SaveWatchlist {
  final MovieRepository movieRepository;
  final TvRepository tvRepository;

  SaveWatchlist({required this.movieRepository, required this.tvRepository});

  Future<Either<Failure, String>> executeMovie(MovieDetail movie) {
    return movieRepository.saveWatchlist(movie);
  }

  Future<Either<Failure, String>> executeTv(TvDetail tv) {
    return tvRepository.saveWatchlist(tv);
  }
}
