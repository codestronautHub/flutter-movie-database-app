import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetWatchlistStatus {
  final MovieRepository movieRepository;
  final TvRepository tvRepository;

  GetWatchlistStatus({
    required this.movieRepository,
    required this.tvRepository,
  });

  Future<bool> executeMovie(int id) async {
    return movieRepository.isAddedToWatchlist(id);
  }

  Future<bool> executeTv(int id) async {
    return tvRepository.isAddedToWatchlist(id);
  }
}
