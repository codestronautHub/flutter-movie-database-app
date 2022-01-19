import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvTable extends Equatable {
  final String? firstAirDate;
  final int id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final double? voteAverage;

  const TvTable({
    required this.firstAirDate,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  factory TvTable.fromMap(Map<String, dynamic> map) => TvTable(
        firstAirDate: map['firstAirDate'],
        id: map['id'],
        name: map['name'],
        overview: map['overview'],
        posterPath: map['posterPath'],
        voteAverage: map['voteAverage'],
      );

  factory TvTable.fromEntity(TvDetail tv) => TvTable(
        firstAirDate: tv.firstAirDate,
        id: tv.id,
        name: tv.name,
        overview: tv.overview,
        posterPath: tv.posterPath,
        voteAverage: tv.voteAverage,
      );

  Map<String, dynamic> toMap() => {
        'firstAirDate': firstAirDate,
        'id': id,
        'name': name,
        'overview': overview,
        'posterPath': posterPath,
        'voteAverage': voteAverage,
      };

  Tv toEntity() => Tv.watchList(
        firstAirDate: firstAirDate,
        id: id,
        name: name,
        overview: overview,
        posterPath: posterPath,
        voteAverage: voteAverage,
      );

  @override
  List<Object?> get props => [
        firstAirDate,
        id,
        name,
        overview,
        posterPath,
        voteAverage,
      ];
}
