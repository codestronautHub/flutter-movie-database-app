import '../repositories/tv_repository.dart';

class GetWatchlistStatus {
  final TvRepository tvRepository;

  GetWatchlistStatus({
    required this.tvRepository,
  });

  Future<bool> executeTv(int id) async {
    return tvRepository.isAddedToWatchlist(id);
  }
}
