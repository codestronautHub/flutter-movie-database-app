import '../repositories/tv_repository.dart';

class GetTvWatchlistStatus {
  final TvRepository tvRepository;

  GetTvWatchlistStatus({
    required this.tvRepository,
  });

  Future<bool> execute(int id) async {
    return tvRepository.isAddedToWatchlist(id);
  }
}
