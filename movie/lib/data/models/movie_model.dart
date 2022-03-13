import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';

class MovieModel extends Equatable {
  int vod_id;
  int type_id;
  int type_id_1;
  String vod_name;
  String vod_en;
  String vod_class;
  String vod_pic;
  String vod_actor;
  String vod_blurb;
  String vod_remarks;
  String vod_area;
  String vod_version;
  String vod_year;
  int vod_hits;
  int vod_hits_day;
  int vod_hits_week;
  int vod_hits_month;
  int vod_up;
  int vod_down;
  String vod_score;
  String vod_time;
  String vod_time_add;
  String vod_content;
  int vod_status;
  String vod_letter;
  String vod_director;

  MovieModel({
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
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
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
        vod_time_add: json['vod_time_add'],
        vod_content: json['vod_content'],
        vod_status: json['vod_status'],
        vod_letter: json['vod_letter'],
        vod_director: json['vod_director'],
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
        'vod_director': vod_director
      };

  Movie toEntity() => Movie(
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
      vod_director: vod_director);

  @override
  List<Object?> get props => [
        vod_id,
        type_id,
        type_id_1,
        vod_name,
        vod_blurb,
        vod_score,
        vod_hits,
        vod_content,
        vod_pic,
      ];
}
