import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ditonton/common/urls.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/provider/movie_images_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/widgets/horizontal_item_list.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainMoviePage extends StatefulWidget {
  @override
  _MainMoviePageState createState() => _MainMoviePageState();
}

class _MainMoviePageState extends State<MainMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<MovieListNotifier>(context, listen: false)
        ..fetchNowPlayingMovies()
        ..fetchPopularMovies()
        ..fetchTopRatedMovies().then((_) =>
            Provider.of<MovieImagesNotifier>(context, listen: false)
                .fetchMovieImages(
                    Provider.of<MovieListNotifier>(context, listen: false)
                        .nowPlayingMovies[0]
                        .id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              if (data.nowPlayingState == RequestState.Loading) {
                return Center(child: CircularProgressIndicator());
              } else if (data.nowPlayingState == RequestState.Loaded) {
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 575.0,
                    autoPlay: false,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      Provider.of<MovieImagesNotifier>(context, listen: false)
                          .fetchMovieImages(data.nowPlayingMovies[index].id);
                    },
                  ),
                  items: data.nowPlayingMovies.map(
                    (item) {
                      return Stack(
                        children: [
                          ShaderMask(
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
                                stops: [0, 0.3, 0.5, 1],
                              ).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height),
                              );
                            },
                            blendMode: BlendMode.dstIn,
                            child: CachedNetworkImage(
                              height: 560.0,
                              imageUrl: Urls.imageUrl(item.backdropPath!),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Colors.redAccent,
                                        size: 16.0,
                                      ),
                                      SizedBox(width: 4.0),
                                      Text(
                                        'Now Playing'.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 16.0),
                                  child: Consumer<MovieImagesNotifier>(
                                    builder: (context, data, child) {
                                      if (data.movieImagesState ==
                                          RequestState.Loading) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (data.movieImagesState ==
                                          RequestState.Loaded) {
                                        if (data
                                            .movieImages.logoPaths.isEmpty) {
                                          return Text(item.title!);
                                        }
                                        return CachedNetworkImage(
                                          width: 200.0,
                                          imageUrl: Urls.imageUrl(
                                            data.movieImages.logoPaths[0],
                                          ),
                                        );
                                      } else {
                                        return Text('Failed');
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                );
              } else {
                return Text('Failed');
              }
            }),
            SubHeading(
              text: 'Popular',
              onSeeMoreTapped: () => Navigator.pushNamed(
                context,
                PopularMoviesPage.ROUTE_NAME,
              ),
            ),
            Consumer<MovieListNotifier>(builder: (context, data, _) {
              if (data.popularMoviesState == RequestState.Loading) {
                return Center(child: CircularProgressIndicator());
              } else if (data.popularMoviesState == RequestState.Loaded) {
                return HorizontalItemList(
                  type: ContentType.Movie,
                  movies: data.popularMovies,
                );
              } else {
                return Text('Failed');
              }
            }),
            SubHeading(
              text: 'Top Rated',
              onSeeMoreTapped: () => Navigator.pushNamed(
                context,
                TopRatedMoviesPage.ROUTE_NAME,
              ),
            ),
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              if (data.topRatedMoviesState == RequestState.Loading) {
                return Center(child: CircularProgressIndicator());
              } else if (data.topRatedMoviesState == RequestState.Loaded) {
                return HorizontalItemList(
                  type: ContentType.Movie,
                  movies: data.topRatedMovies,
                );
              } else {
                return Text('Failed');
              }
            }),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
