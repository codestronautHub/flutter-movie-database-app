import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_episode.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTvSeasons {
  final TvRepository repository;

  GetTvSeasons(this.repository);

  Future<Either<Failure, List<TvEpisode>>> execute(id, seasonNumber) {
    return repository.getTvSeasonEpisodes(id, seasonNumber);
  }
}
