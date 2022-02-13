import '../repositories/movie_repository.dart';

class GetMovieWatchlistStatus {
  final MovieRepository movieRepository;

  GetMovieWatchlistStatus({
    required this.movieRepository,
  });

  Future<bool> execute(int id) async {
    return movieRepository.isAddedToWatchlist(id);
  }
}
