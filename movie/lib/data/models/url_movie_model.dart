import 'package:equatable/equatable.dart';
import '../../domain/entities/url_movie.dart';

class UrlMovieModel extends Equatable {
  final int nid;
  final String name;
  final String url;

  const UrlMovieModel({
    required this.nid,
    required this.name,
    required this.url,
  });
  factory UrlMovieModel.fromJson(Map<String, dynamic> json) => UrlMovieModel(
        nid: json['nid'],
        name: json['name'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'nid': nid,
        'name': name,
        'url': url,
      };

  UrlMovie toEntity() => UrlMovie(
        nid: nid,
        name: name,
        url: url,
      );
  @override
  List<Object> get props => [nid, name, url];
}
