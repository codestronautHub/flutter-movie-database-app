import 'package:dartz/dartz.dart';
import '../../core.dart';
import '../entities/tv_season_episode.dart';
import '../repositories/tv_repository.dart';

class GetTvSeasonEpisodes {
  final TvRepository repository;

  GetTvSeasonEpisodes(this.repository);

  Future<Either<Failure, List<TvSeasonEpisode>>> execute(id, seasonNumber) {
    return repository.getTvSeasonEpisodes(id, seasonNumber);
  }
}
