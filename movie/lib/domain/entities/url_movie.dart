import 'package:equatable/equatable.dart';

class UrlMovie extends Equatable {
  final int nid;
  final String name;
  final String url;

  const UrlMovie({
    required this.nid,
    required this.name,
    required this.url,
  });

  @override
  List<Object> get props => [nid, name, url];
}
