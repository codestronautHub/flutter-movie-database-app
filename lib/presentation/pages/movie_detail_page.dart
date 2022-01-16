import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/urls.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/widgets/minimal_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/movie-detail';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MovieDetailNotifier>(context, listen: false)
          .fetchMovieDetail(widget.id);
      Provider.of<MovieDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.movieState == RequestState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.movieState == RequestState.Loaded) {
            final movie = provider.movie;
            return MovieDetailContent(
              movie: movie,
              recommendations: provider.recommendations,
              isAddedToWatchlist: provider.isAddedToWatchlist,
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class MovieDetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedToWatchlist;
  const MovieDetailContent({
    required this.movie,
    required this.recommendations,
    required this.isAddedToWatchlist,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            background: FadeIn(
              duration: Duration(milliseconds: 500),
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                      Colors.black,
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.5, 1.0, 1.0],
                  ).createShader(
                    Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                  );
                },
                blendMode: BlendMode.dstIn,
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width,
                  imageUrl: Urls.imageUrl(movie.backdropPath!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: FadeInUp(
            from: 20,
            duration: Duration(milliseconds: 500),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: kHeading5.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          movie.releaseDate.split('-')[0],
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20.0,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            (movie.voteAverage / 2).toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            '(${movie.voteAverage})',
                            style: TextStyle(
                              fontSize: 1.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16.0),
                      Text(
                        _showDuration(movie.runtime),
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (!isAddedToWatchlist) {
                        await Provider.of<MovieDetailNotifier>(context,
                                listen: false)
                            .addToWatchlist(movie);
                      } else {
                        await Provider.of<MovieDetailNotifier>(context,
                                listen: false)
                            .removeFromWatchlist(movie);
                      }

                      final message = Provider.of<MovieDetailNotifier>(context,
                              listen: false)
                          .watchlistMessage;

                      if (message ==
                              MovieDetailNotifier.watchlistAddSuccessMessage ||
                          message ==
                              MovieDetailNotifier
                                  .watchlistRemoveSuccessMessage) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(message)));
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(message),
                            );
                          },
                        );
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        isAddedToWatchlist
                            ? Icon(Icons.check, color: Colors.white)
                            : Icon(Icons.add, color: Colors.black),
                        SizedBox(width: 16.0),
                        Text(
                          isAddedToWatchlist
                              ? 'Added to watchlist'
                              : 'Add to watchlist',
                          style: TextStyle(
                            color: isAddedToWatchlist
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary:
                          isAddedToWatchlist ? Colors.grey[850] : Colors.white,
                      minimumSize: Size(
                        MediaQuery.of(context).size.width,
                        42.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    movie.overview,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Genres: ${_showGenres(movie.genres)}',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
          sliver: SliverToBoxAdapter(
            child: FadeInUp(
              from: 20,
              duration: Duration(milliseconds: 500),
              child: Text(
                'More like this'.toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),
        // Tab(text: 'More like this'.toUpperCase()),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
          sliver: _showRecommendations(),
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Widget _showRecommendations() {
    return Consumer<MovieDetailNotifier>(
      builder: (context, data, child) {
        if (data.recommendationsState == RequestState.Loaded) {
          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final recommendation = data.recommendations[index];
                return FadeInUp(
                  from: 20,
                  duration: Duration(milliseconds: 500),
                  child: GestureDetector(
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
                            type: MdbContentType.Movie,
                            movie: recommendation,
                          );
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      child: CachedNetworkImage(
                        imageUrl: Urls.imageUrl(recommendation.posterPath!),
                        placeholder: (context, url) => Shimmer.fromColors(
                          child: Container(
                            height: 170.0,
                            width: 120.0,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          baseColor: Colors.grey[850]!,
                          highlightColor: Colors.grey[800]!,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        height: 180.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              childCount: data.recommendations.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.7,
              crossAxisCount:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? 3
                      : 4,
            ),
          );
        } else if (data.recommendationsState == RequestState.Error) {
          return SliverToBoxAdapter(child: Center(child: Text(data.message)));
        } else {
          return SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
