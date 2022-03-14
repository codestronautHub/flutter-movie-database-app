import 'package:equatable/equatable.dart';
import '../../domain/entities/tv.dart';

class TvModel extends Equatable {
  int vod_id;
  String vod_name;
  String? vod_en;
  String? vod_class;
  String vod_pic;
  String? vod_actor;
  String? vod_blurb;
  String? vod_remarks;
  String? vod_area;
  String? vod_version;
  String? vod_year;
  int? vod_hits;
  int? vod_hits_day;
  int? vod_hits_week;
  int? vod_hits_month;
  int? vod_up;
  int? vod_down;
  String? vod_score;
  String? vod_time;
  String? vod_time_add;
  String? vod_content;
  int? vod_status;
  String? vod_letter;
  String? vod_director;

  TvModel({
    required this.vod_id,
    required this.vod_name,
    required this.vod_en,
    this.vod_class,
    required this.vod_pic,
    this.vod_actor,
    this.vod_blurb,
    this.vod_remarks,
    this.vod_area,
    this.vod_version,
    this.vod_year,
    this.vod_hits,
    this.vod_hits_day,
    this.vod_hits_week,
    this.vod_hits_month,
    this.vod_up,
    this.vod_down,
    this.vod_score,
    this.vod_time,
    this.vod_time_add,
    this.vod_content,
    this.vod_status,
    this.vod_letter,
    this.vod_director,
  });

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        vod_id: json['vod_id'],
        vod_name: json['vod_name'],
        vod_en: json['vod_en'],
        vod_pic: json['vod_pic'],
        vod_class: json['vod_class'],
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
        vod_time: json['vod_time'].toString(),
        vod_time_add: json['vod_time_add'].toString(),
        vod_content: json['vod_content'],
        vod_status: json['vod_status'],
        vod_letter: json['vod_letter'],
        vod_director: json['vod_director'],
      );

  Map<String, dynamic> toJson() => {
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

  Tv toEntity() => Tv(
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
        vod_blurb,
        vod_score,
        vod_hits,
        vod_content,
        vod_pic,
      ];
}
