import 'package:dartz/dartz.dart';
import '../../core.dart';
import '../entities/media_image.dart';
import '../entities/tv.dart';
import '../entities/tv_detail.dart';
import '../entities/tv_season_episode.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getOnTheAirTvs();
  Future<Either<Failure, List<Tv>>> getPopularTvs();
  Future<Either<Failure, List<Tv>>> getTopRatedTvs();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id);
  Future<Either<Failure, List<TvSeasonEpisode>>> getTvSeasonEpisodes(
      int id, int seasonNumber);
  Future<Either<Failure, List<Tv>>> searchTvs(String query);
  Future<Either<Failure, MediaImage>> getTvImages(int id);
  Future<Either<Failure, String>> saveWatchlist(TvDetail tv);
  Future<Either<Failure, String>> removeWatchlist(TvDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTvs();
}
