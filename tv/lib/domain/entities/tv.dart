import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Tv extends Equatable {
  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int id;
  String? name;
  String? overview;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  Tv({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  Tv.watchList({
    required this.firstAirDate,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        name,
        overview,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
