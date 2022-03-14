import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';

class MovieTable extends Equatable {
  final int vod_id;
  final String vod_name;
  final String vod_en;
  final String vod_class;
  final String vod_pic;
  final String vod_actor;
  final String vod_blurb;
  final String vod_remarks;
  final String vod_area;
  final String vod_version;
  final String vod_year;
  final int vod_hits;
  final int vod_hits_day;
  final int vod_hits_week;
  final int vod_hits_month;
  final int vod_up;
  final int vod_down;
  final String vod_score;
  final String vod_time;
  final String vod_time_add;
  final String vod_content;
  final int vod_status;
  final String vod_letter;
  final String vod_director;

  const MovieTable({
    required this.vod_id,
    required this.vod_name,
    required this.vod_en,
    required this.vod_class,
    required this.vod_pic,
    required this.vod_actor,
    required this.vod_blurb,
    required this.vod_remarks,
    required this.vod_area,
    required this.vod_version,
    required this.vod_year,
    required this.vod_hits,
    required this.vod_hits_day,
    required this.vod_hits_week,
    required this.vod_hits_month,
    required this.vod_up,
    required this.vod_down,
    required this.vod_score,
    required this.vod_time,
    required this.vod_time_add,
    required this.vod_content,
    required this.vod_status,
    required this.vod_letter,
    required this.vod_director,
  });

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
      vod_id: map['vod_id'],
      vod_name: map['vod_name'],
      vod_en: map['vod_en'],
      vod_class: map['vod_class'],
      vod_pic: map['vod_pic'],
      vod_actor: map['vod_actor'],
      vod_blurb: map['vod_blurb'],
      vod_remarks: map['vod_remarks'],
      vod_area: map['vod_area'],
      vod_version: map['vod_version'],
      vod_year: map['vod_year'],
      vod_hits: map['vod_hits'],
      vod_hits_day: map['vod_hits_day'],
      vod_hits_week: map['vod_hits_week'],
      vod_hits_month: map['vod_hits_month'],
      vod_up: map['vod_up'],
      vod_down: map['vod_down'],
      vod_score: map['vod_score'],
      vod_time: map['vod_time'],
      vod_time_add: map['vod_time_add'],
      vod_content: map['vod_content'],
      vod_status: map['vod_status'],
      vod_letter: map['vod_letter'],
      vod_director: map['vod_director']);

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
      vod_id: movie.vod_id,
      vod_name: movie.vod_name,
      vod_en: movie.vod_en,
      vod_class: movie.vod_class,
      vod_pic: movie.vod_pic,
      vod_actor: movie.vod_actor,
      vod_blurb: movie.vod_blurb,
      vod_remarks: movie.vod_remarks,
      vod_area: movie.vod_area,
      vod_version: movie.vod_version,
      vod_year: movie.vod_year,
      vod_hits: movie.vod_hits,
      vod_hits_day: movie.vod_hits_day,
      vod_hits_week: movie.vod_hits_week,
      vod_hits_month: movie.vod_hits_month,
      vod_up: movie.vod_up,
      vod_down: movie.vod_down,
      vod_score: movie.vod_score,
      vod_time: movie.vod_time,
      vod_time_add: movie.vod_time_add,
      vod_content: movie.vod_content,
      vod_status: movie.vod_status,
      vod_letter: movie.vod_letter,
      vod_director: movie.vod_director);

  Map<String, dynamic> toMap() => {
        'vod_id': vod_id,
        'vod_name': vod_name,
        'vod_en': vod_en,
        'vod_class': vod_class,
        'vod_pic': vod_pic,
        'vod_actor': vod_actor,
        'vod_blurb': vod_blurb,
        'vod_remarks': vod_remarks,
        'vod_area': vod_area,
        'vod_version': vod_version,
        'vod_year': vod_year,
        'vod_hits': vod_hits,
        'vod_hits_day': vod_hits_day,
        'vod_hits_week': vod_hits_week,
        'vod_hits_month': vod_hits_month,
        'vod_up': vod_up,
        'vod_down': vod_down,
        'vod_score': vod_score,
        'vod_time': vod_time,
        'vod_time_add': vod_time_add,
        'vod_content': vod_content,
        'vod_status': vod_status,
        'vod_letter': vod_letter,
        'vod_director': vod_director
      };

  Movie toEntity() => Movie.watchlist(
      vod_id: vod_id,
      vod_name: vod_name,
      vod_en: vod_en,
      vod_class: vod_class,
      vod_pic: vod_pic,
      vod_actor: vod_actor,
      vod_blurb: vod_blurb,
      vod_remarks: vod_remarks,
      vod_area: vod_area,
      vod_version: vod_version,
      vod_year: vod_year,
      vod_hits: vod_hits,
      vod_hits_day: vod_hits_day,
      vod_hits_week: vod_hits_week,
      vod_hits_month: vod_hits_month,
      vod_up: vod_up,
      vod_down: vod_down,
      vod_score: vod_score,
      vod_time: vod_time,
      vod_time_add: vod_time_add,
      vod_content: vod_content,
      vod_status: vod_status,
      vod_letter: vod_letter,
      vod_director: vod_director);

  @override
  List<Object?> get props => [
        vod_id,
        vod_name,
        vod_en,
        vod_class,
        vod_pic,
        vod_actor,
        vod_blurb,
        vod_remarks,
        vod_area,
        vod_version,
        vod_year,
        vod_hits,
        vod_hits_day,
        vod_hits_week,
        vod_hits_month,
        vod_up,
        vod_down,
        vod_score,
        vod_time,
        vod_time_add,
        vod_content,
        vod_status,
        vod_letter,
        vod_director
      ];
}
