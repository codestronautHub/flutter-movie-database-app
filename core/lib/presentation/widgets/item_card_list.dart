import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/tv_detail_page.dart';

class ItemCard extends StatelessWidget {
  final MdbContentType type;
  final Movie? movie;
  final Tv? tv;

  const ItemCard({
    Key? key,
    required this.type,
    this.movie,
    this.tv,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (type == MdbContentType.movie) {
          Navigator.pushNamed(
            context,
            MovieDetailPage.routeName,
            arguments: movie!.id,
          );
        } else {
          Navigator.pushNamed(
            context,
            TvDetailPage.routeName,
            arguments: tv!.id,
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: Urls.imageUrl(
                    type == MdbContentType.movie
                        ? movie!.posterPath!
                        : tv!.posterPath!,
                  ),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type == MdbContentType.movie
                        ? movie!.title ?? '-'
                        : tv!.name ?? '-',
                    overflow: TextOverflow.ellipsis,
                    style: kHeading6,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(type == MdbContentType.movie
                            ? movie!.releaseDate!.split('-')[0]
                            : tv!.firstAirDate!.split('-')[0]),
                      ),
                      const SizedBox(width: 16.0),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        type == MdbContentType.movie
                            ? (movie!.voteAverage! / 2).toStringAsFixed(1)
                            : (tv!.voteAverage! / 2).toStringAsFixed(1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    type == MdbContentType.movie
                        ? movie!.overview ?? '-'
                        : tv!.overview ?? '-',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
