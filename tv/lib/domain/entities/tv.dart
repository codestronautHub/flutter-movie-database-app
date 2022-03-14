import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Tv extends Equatable {
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
  Tv({
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

  Tv.watchlist({
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
