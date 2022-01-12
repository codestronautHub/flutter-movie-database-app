import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailModel extends Equatable {
  final String? backdropPath;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final List<GenreModel> genres;
  final int id;
  final String name;
  final int numberOfSeasons;
  final String overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;

  TvDetailModel({
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.name,
    required this.numberOfSeasons,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvDetailModel.fromJson(Map<String, dynamic> json) => TvDetailModel(
        backdropPath: json['backdrop_path'],
        episodeRunTime: List<int>.from(json['episode_run_time'].map((x) => x)),
        firstAirDate: json['first_air_date'],
        genres: List<GenreModel>.from(
            json['genres'].map((x) => GenreModel.fromJson(x))),
        id: json['id'],
        name: json['name'],
        numberOfSeasons: json['number_of_seasons'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
      );

  Map<String, dynamic> toJson() => {
        'backdrop_path': backdropPath,
        'episode_run_time': List<dynamic>.from(episodeRunTime.map((x) => x)),
        'first_air_date': firstAirDate,
        'genres': List<dynamic>.from(genres.map((x) => x.toJson())),
        'id': id,
        'name': name,
        'number_of_seasons': numberOfSeasons,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  TvDetail toEntity() => TvDetail(
        backdropPath: this.backdropPath,
        episodeRunTime: this.episodeRunTime,
        firstAirDate: this.firstAirDate,
        genres: this.genres.map((genre) => genre.toEntity()).toList(),
        id: this.id,
        name: this.name,
        numberOfSeasons: this.numberOfSeasons,
        overview: this.overview,
        popularity: this.popularity,
        posterPath: this.posterPath,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount,
      );

  @override
  List<Object?> get props => [
        backdropPath,
        episodeRunTime,
        firstAirDate,
        genres,
        id,
        name,
        numberOfSeasons,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
