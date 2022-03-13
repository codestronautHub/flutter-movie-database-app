import 'package:equatable/equatable.dart';

import 'movie_model.dart';

class MovieResponse extends Equatable {
  final List<MovieModel> movieList;

  const MovieResponse({required this.movieList});

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        movieList: List<MovieModel>.from(
            (json['list'] as List).map((x) => MovieModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'list': List<dynamic>.from(movieList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [movieList];
}
