import 'package:equatable/equatable.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/entities/play_url.dart';
import 'genre_model.dart';
import 'play_url_model.dart';

class MovieDetailResponse extends Equatable {
  final int vod_id;
  final int type_id;
  final int type_id_1;
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
  final List<PlayUrlModel> vod_play_url;

  const MovieDetailResponse({
    required this.vod_id,
    required this.type_id,
    required this.type_id_1,
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
    required this.vod_play_url,
  });

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) =>
      MovieDetailResponse(
        vod_id: json['vod_id'],
        type_id: json['type_id'],
        type_id_1: json['type_id_1'],
        vod_name: json['vod_name'],
        vod_en: json['vod_en'],
        vod_class: json['vod_class'],
        vod_pic: json['vod_pic'],
        vod_actor: json['vod_actor'],
        vod_blurb: json['vod_blurb'],
        vod_remarks: json['vod_remarks'],
        vod_area: json['vod_area'],
        vod_version: json['vod_version'],
        vod_year: json['vod_year'],
        vod_hits: json['vod_hits'],
        vod_hits_day: json['vod_hits_day'],
        vod_hits_week: json['vod_hits_week'],
        vod_hits_month: json['vod_hits_month'],
        vod_up: json['vod_up'],
        vod_down: json['vod_down'],
        vod_score: json['vod_score'],
        vod_time: json['vod_time'],
        vod_time_add: json['vod_time'],
        vod_content: json['vod_content'],
        vod_status: json['vod_status'],
        vod_letter: json['vod_letter'],
        vod_director: json['vod_director'],
        vod_play_url: List<PlayUrlModel>.from((json['vod_play_url'] as List)
            .map((x) => PlayUrlModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'vod_id': vod_id,
        'type_id': type_id,
        'type_id_1': type_id_1,
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
        'vod_director': vod_director,
        'vod_play_url': List<dynamic>.from(vod_play_url.map((x) => x.toJson())),
      };

  MovieDetail toEntity() => MovieDetail(
        vod_id: vod_id,
        type_id: type_id,
        type_id_1: type_id_1,
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
        vod_director: vod_director,
        vod_play_url: vod_play_url.map((url) => url.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [
        vod_id,
        type_id,
        type_id_1,
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
