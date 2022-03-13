import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';
import '../../data/models/url_movie_model.dart';
import '../../domain/entities/url_movie.dart';
import '../../domain/entities/play_url.dart';

class PlayUrlModel extends Equatable {
  final int sid;
  final String from;
  final List<UrlMovieModel> urls;

  const PlayUrlModel({
    required this.sid,
    required this.from,
    required this.urls,
  });

  factory PlayUrlModel.fromJson(Map<String, dynamic> json) => PlayUrlModel(
        sid: json['sid'],
        from: json['from'],
        urls: List<UrlMovieModel>.from(
            (json['urls'] as List).map((x) => UrlMovieModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'sid': sid,
        'from': from,
        'urls': List<dynamic>.from(urls.map((x) => x.toJson())),
      };

  PlayUrl toEntity() => PlayUrl(
        sid: sid,
        from: from,
        urls: urls.map((url) => url.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [
        sid,
        from,
        urls,
      ];
}
