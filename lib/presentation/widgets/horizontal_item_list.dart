import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/urls.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/widgets/minimal_detail.dart';
import 'package:flutter/material.dart';

class HorizontalItemList extends StatelessWidget {
  final ContentType type;
  final List<Movie>? movies;
  final List<Tv>? tvs;

  HorizontalItemList({required this.type, this.movies, this.tvs});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ContentType.Movie:
        return Container(
          height: 170.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: movies!.length,
            itemBuilder: (context, index) {
              final movie = movies![index];
              return Container(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return MinimalDetail(
                          type: type,
                          movie: movie,
                        );
                      },
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    child: CachedNetworkImage(
                      imageUrl: Urls.imageUrl(movie.posterPath!),
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      case ContentType.Tv:
        return Container(
          height: 170.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: tvs!.length,
            itemBuilder: (context, index) {
              final tv = tvs![index];
              return Container(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return MinimalDetail(
                          type: type,
                          tv: tv,
                        );
                      },
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    child: CachedNetworkImage(
                      imageUrl: Urls.imageUrl(tv.posterPath!),
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              );
            },
          ),
        );
    }
  }
}
