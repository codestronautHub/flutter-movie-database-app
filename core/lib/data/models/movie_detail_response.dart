import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class MovieDetailResponse extends Equatable {
  final String? backdropPath;
  final List<GenreModel> genres;
  final int id;
  final String overview;
  final String? posterPath;
  final String releaseDate;
  final int runtime;
  final String title;
  final double voteAverage;
  final int voteCount;

  MovieDetailResponse({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) =>
      MovieDetailResponse(
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        runtime: json["runtime"],
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "overview": overview,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "runtime": runtime,
        "title": title,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  MovieDetail toEntity() => MovieDetail(
        backdropPath: this.backdropPath,
        genres: this.genres.map((genre) => genre.toEntity()).toList(),
        id: this.id,
        overview: this.overview,
        posterPath: this.posterPath,
        releaseDate: this.releaseDate,
        runtime: this.runtime,
        title: this.title,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount,
      );

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        overview,
        posterPath,
        releaseDate,
        runtime,
        title,
        voteAverage,
        voteCount,
      ];
}
