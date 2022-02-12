import '../repositories/movie_repository.dart';

class GetWatchlistStatus {
  final MovieRepository movieRepository;

  GetWatchlistStatus({
    required this.movieRepository,
  });

  Future<bool> executeMovie(int id) async {
    return movieRepository.isAddedToWatchlist(id);
  }
}
