import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ditonton/common/urls.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/provider/movie_images_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/widgets/horizontal_item_list.dart';
import 'package:ditonton/presentation/widgets/minimal_detail.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MainMoviePage extends StatefulWidget {
  @override
  _MainMoviePageState createState() => _MainMoviePageState();
}

class _MainMoviePageState extends State<MainMoviePage> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    Future.microtask(
      () => Provider.of<MovieListNotifier>(context, listen: false)
        ..fetchNowPlayingMovies()
        ..fetchPopularMovies()
        ..fetchTopRatedMovies().whenComplete(
          () => Provider.of<MovieImagesNotifier>(context, listen: false)
              .fetchMovieImages(
                  Provider.of<MovieListNotifier>(context, listen: false)
                      .nowPlayingMovies[0]
                      .id),
        ),
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
              if (data.nowPlayingState == RequestState.Loaded) {
                return FadeIn(
                  duration: Duration(milliseconds: 500),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 575.0,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        Provider.of<MovieImagesNotifier>(context, listen: false)
                            .fetchMovieImages(data.nowPlayingMovies[index].id);
                      },
                    ),
                    items: data.nowPlayingMovies.map(
                      (item) {
                        return GestureDetector(
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
                                  movie: item,
                                );
                              },
                            );
                          },
                          child: Stack(
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
                                    Rect.fromLTRB(
                                        0, 0, rect.width, rect.height),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                              RequestState.Loaded) {
                                            if (data.movieImages.logoPaths
                                                .isEmpty) {
                                              return Text(item.title!);
                                            }
                                            return CachedNetworkImage(
                                              width: 200.0,
                                              imageUrl: Urls.imageUrl(
                                                data.movieImages.logoPaths[0],
                                              ),
                                            );
                                          } else if (data.movieImagesState ==
                                              RequestState.Error) {
                                            return Center(
                                              child: Text('Load data failed'),
                                            );
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                );
              } else if (data.nowPlayingState == RequestState.Error) {
                return Center(child: Text('Load data failed'));
              } else {
                return ShaderMask(
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
                  child: Shimmer.fromColors(
                    child: Container(
                      height: 575.0,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black,
                    ),
                    baseColor: Colors.grey[850]!,
                    highlightColor: Colors.grey[800]!,
                  ),
                );
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
              if (data.popularMoviesState == RequestState.Loaded) {
                return FadeIn(
                  duration: Duration(milliseconds: 500),
                  child: HorizontalItemList(
                    type: MdbContentType.Movie,
                    movies: data.popularMovies,
                  ),
                );
              } else if (data.popularMoviesState == RequestState.Error) {
                return Center(child: Text('Load data failed'));
              } else {
                return Container(
                  height: 170.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Shimmer.fromColors(
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
                      );
                    },
                  ),
                );
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
              if (data.topRatedMoviesState == RequestState.Loaded) {
                return FadeIn(
                  duration: Duration(milliseconds: 500),
                  child: HorizontalItemList(
                    type: MdbContentType.Movie,
                    movies: data.topRatedMovies,
                  ),
                );
              } else if (data.topRatedMoviesState == RequestState.Error) {
                return Center(child: Text('Load data failed'));
              } else {
                return Container(
                  height: 170.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Shimmer.fromColors(
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
                      );
                    },
                  ),
                );
              }
            }),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
