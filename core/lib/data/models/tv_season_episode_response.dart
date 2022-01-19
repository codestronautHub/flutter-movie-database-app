import 'package:core/data/models/tv_season_episode_model.dart';
import 'package:equatable/equatable.dart';

class TvSeasonEpisodeResponse extends Equatable {
  final List<TvSeasonEpisodeModel> tvEpisodes;

  const TvSeasonEpisodeResponse({
    required this.tvEpisodes,
  });

  factory TvSeasonEpisodeResponse.fromJson(Map<String, dynamic> json) =>
      TvSeasonEpisodeResponse(
        tvEpisodes: List<TvSeasonEpisodeModel>.from((json['episodes'] as List)
            .map((x) => TvSeasonEpisodeModel.fromJson(x))
            .where((element) => element.stillPath != null)),
      );

  Map<String, dynamic> toJson() => {
        'episodes': List<dynamic>.from(tvEpisodes.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        tvEpisodes,
      ];
}
