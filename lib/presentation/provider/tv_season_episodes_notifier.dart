import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_season_episode.dart';
import 'package:ditonton/domain/usecases/get_tv_season_episodes.dart';
import 'package:flutter/material.dart';

class TvSeasonEpisodesNotifier extends ChangeNotifier {
  final GetTvSeasonEpisodes getTvSeasonEpisodes;

  TvSeasonEpisodesNotifier({required this.getTvSeasonEpisodes});

  late List<TvSeasonEpisode> _seasonEpisodes;
  List<TvSeasonEpisode> get seasonEpisodes => _seasonEpisodes;

  RequestState _seasonEpisodesState = RequestState.Empty;
  RequestState get seasonEpisodesState => _seasonEpisodesState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeasonEpisodes(int id, int seasonNumber) async {
    _seasonEpisodesState = RequestState.Loading;
    notifyListeners();

    final seasonEpisodesResult =
        await getTvSeasonEpisodes.execute(id, seasonNumber);

    seasonEpisodesResult.fold(
      (failure) {
        _seasonEpisodesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seasonEpisode) {
        _seasonEpisodesState = RequestState.Loaded;
        _seasonEpisodes = seasonEpisode;
        notifyListeners();
      },
    );
  }
}
