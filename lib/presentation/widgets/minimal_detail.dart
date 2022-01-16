import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/urls.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';

class MinimalDetail extends StatelessWidget {
  final MdbContentType type;
  final Movie? movie;
  final Tv? tv;

  const MinimalDetail({
    Key? key,
    required this.type,
    this.movie,
    this.tv,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: Urls.imageUrl(
                        type == MdbContentType.Movie
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
                SizedBox(width: 16.0),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              type == MdbContentType.Movie
                                  ? movie!.title ?? '-'
                                  : tv!.name ?? '-',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: UnconstrainedBox(
                              child: SizedBox(
                                height: 36.0,
                                width: 36.0,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(1000.0),
                                    ),
                                    backgroundColor:
                                        Colors.white.withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(type == MdbContentType.Movie
                                ? movie!.releaseDate!.split('-')[0]
                                : tv!.firstAirDate!.split('-')[0]),
                          ),
                          SizedBox(width: 16.0),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18.0,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            type == MdbContentType.Movie
                                ? (movie!.voteAverage! / 2).toStringAsFixed(1)
                                : (tv!.voteAverage! / 2).toStringAsFixed(1),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        type == MdbContentType.Movie
                            ? movie!.overview ?? '-'
                            : tv!.overview ?? '-',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1.0,
            color: Colors.white70,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                if (type == MdbContentType.Movie) {
                  Navigator.pushNamed(
                    context,
                    MovieDetailPage.ROUTE_NAME,
                    arguments: movie!.id,
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    TvDetailPage.ROUTE_NAME,
                    arguments: tv!.id,
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, size: 16.0),
                      SizedBox(width: 8.0),
                      Text('Detail & More'),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, size: 16.0),
                ],
              ),
              style: TextButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
