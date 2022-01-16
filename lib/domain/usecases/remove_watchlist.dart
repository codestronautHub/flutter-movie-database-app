import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

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
