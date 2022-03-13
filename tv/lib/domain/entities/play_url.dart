import 'package:equatable/equatable.dart';

import 'url_movie.dart';

class PlayUrl extends Equatable {
  final int sid;
  final String from;
  final List<UrlMovie> urls;

  const PlayUrl({
    required this.sid,
    required this.from,
    required this.urls,
  });

  @override
  List<Object> get props => [sid, from, urls];
}
