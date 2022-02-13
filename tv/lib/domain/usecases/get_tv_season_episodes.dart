import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv_season_episode.dart';
import '../repositories/tv_repository.dart';

class GetTvSeasonEpisodes {
  final TvRepository repository;

  GetTvSeasonEpisodes(this.repository);

  Future<Either<Failure, List<TvSeasonEpisode>>> execute(id, seasonNumber) {
    return repository.getTvSeasonEpisodes(id, seasonNumber);
  }
}
