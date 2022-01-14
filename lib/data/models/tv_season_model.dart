import 'package:ditonton/data/models/tv_episode_model.dart';
import 'package:equatable/equatable.dart';

class TvSeasonModel extends Equatable {
  final List<TvEpisodeModel> tvEpisodes;

  TvSeasonModel({
    required this.tvEpisodes,
  });

  factory TvSeasonModel.fromJson(Map<String, dynamic> json) => TvSeasonModel(
        tvEpisodes: List<TvEpisodeModel>.from(
            (json['episodes'] as List).map((x) => TvEpisodeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'episodes': List<dynamic>.from(tvEpisodes.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        tvEpisodes,
      ];
}
