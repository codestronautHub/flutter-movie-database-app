import 'package:ditonton/data/models/tv_season_episode_model.dart';
import 'package:equatable/equatable.dart';

class TvSeasonEpisodesModel extends Equatable {
  final List<TvSeasonEpisodeModel> tvEpisodes;

  TvSeasonEpisodesModel({
    required this.tvEpisodes,
  });

  factory TvSeasonEpisodesModel.fromJson(Map<String, dynamic> json) =>
      TvSeasonEpisodesModel(
        tvEpisodes: List<TvSeasonEpisodeModel>.from((json['episodes'] as List)
            .map((x) => TvSeasonEpisodeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'episodes': List<dynamic>.from(tvEpisodes.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        tvEpisodes,
      ];
}
