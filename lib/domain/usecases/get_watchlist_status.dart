import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetWatchListStatus {
  final MovieRepository movieRepository;
  final TvRepository tvRepository;

  GetWatchListStatus({
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
