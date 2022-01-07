import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/urls.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final ContentType type;
  final Movie? movie;
  final Tv? tv;

  ItemCard({
    required this.type,
    this.movie,
    this.tv,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          if (type == ContentType.Movie) {
            Navigator.pushNamed(
              context,
              MovieDetailPage.ROUTE_NAME,
              arguments: movie!.id,
            );
          } else {
            // TODO: Go to tv detail page
          }
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16.0 + 80.0 + 16.0,
                  bottom: 8.0,
                  right: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type == ContentType.Movie
                          ? movie!.title ?? '-'
                          : tv!.name ?? '-',
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                      maxLines: 1,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      type == ContentType.Movie
                          ? movie!.overview ?? '-'
                          : tv!.overview ?? '-',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16.0,
                bottom: 16.0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: CachedNetworkImage(
                  width: 80.0,
                  imageUrl: Urls.imageUrl(
                    type == ContentType.Movie
                        ? movie!.posterPath!
                        : tv!.posterPath!,
                  ),
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
