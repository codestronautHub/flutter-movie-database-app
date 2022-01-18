import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';

class RemoveWatchlist {
  final MovieRepository movieRepository;
  final TvRepository tvRepository;

  RemoveWatchlist({required this.movieRepository, required this.tvRepository});

  Future<Either<Failure, String>> executeMovie(MovieDetail movie) {
    return movieRepository.removeWatchlist(movie);
  }

  Future<Either<Failure, String>> executeTv(TvDetail tv) {
    return tvRepository.removeWatchlist(tv);
  }
}
