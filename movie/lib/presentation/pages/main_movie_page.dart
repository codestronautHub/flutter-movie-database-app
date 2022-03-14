import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/movie_images_notifier.dart';
import '../provider/movie_list_notifier.dart';
import '../widgets/horizontal_item_list.dart';
import '../widgets/minimal_detail.dart';
import '../widgets/sub_heading.dart';
import 'popular_movies_page.dart';
import 'top20_chinese_movies_page.dart';
import 'top_Hq_movies_page.dart';
import 'top_rated_movies_page.dart';
import 'top_Ac_movies_page.dart';

class MainMoviePage extends StatefulWidget {
  const MainMoviePage({Key? key}) : super(key: key);

  @override
  _MainMoviePageState createState() => _MainMoviePageState();
}

class _MainMoviePageState extends State<MainMoviePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<MovieListNotifier>(context, listen: false)
          .fetchNowPlayingMovies()
          .whenComplete(
            () => Provider.of<MovieImagesNotifier>(context, listen: false)
                .fetchMovieImages(
              Provider.of<MovieListNotifier>(context, listen: false)
                  .nowPlayingMovies[0]
                  .vod_id,
            ),
          );
      Provider.of<MovieListNotifier>(context, listen: false)
          .fetchPopularMovies();
      Provider.of<MovieListNotifier>(context, listen: false)
          .fetchTopRatedMovies();
      Provider.of<MovieListNotifier>(context, listen: false)
          .fetchTop20ChineseMovies();
      Provider.of<MovieListNotifier>(context, listen: false)
          .fetchTopHqMovies();
      Provider.of<MovieListNotifier>(context, listen: false)
          .fetchTopAcMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        key: const Key('movieScrollView'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              if (data.nowPlayingState == RequestState.loaded) {
                return FadeIn(
                  duration: const Duration(milliseconds: 500),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 575.0,
                      viewportFraction: 1.0,
                    ),
                    items: data.nowPlayingMovies.map(
                      (item) {
                        return GestureDetector(
                          key: const Key('openMovieMinimalDetail'),
                          onTap: () {
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return MinimalDetail(
                                  keyValue: 'goToMovieDetail',
                                  closeKeyValue: 'closeMovieMinimalDetail',
                                  movie: item,
                                );
                              },
                            );
                          },
                          child: Stack(
                            children: [
                              ShaderMask(
                                shaderCallback: (rect) {
                                  return const LinearGradient(
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
                                  imageUrl: item.vod_pic,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.circle,
                                            color: Colors.redAccent,
                                            size: 16.0,
                                          ),
                                          const SizedBox(width: 4.0),
                                          Text(
                                            'Now Playing'.toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              item.vod_name.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.lightBlue,
                                              ),
                                            ),
                                          )
                                        ],
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
              } else if (data.nowPlayingState == RequestState.error) {
                return const Center(child: Text('Load data failed'));
              } else {
                return ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
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
              valueKey: 'seePopularMovies',
              text: 'Phim phổ biến',
              onSeeMoreTapped: () => Navigator.pushNamed(
                context,
                PopularMoviesPage.routeName,
              ),
            ),
            Consumer<MovieListNotifier>(builder: (context, data, _) {
              if (data.popularMoviesState == RequestState.loaded) {
                return FadeIn(
                  duration: const Duration(milliseconds: 500),
                  child: HorizontalItemList(
                    movies: data.popularMovies,
                  ),
                );
              } else if (data.popularMoviesState == RequestState.error) {
                return const Center(child: Text('Load data failed'));
              } else {
                return SizedBox(
                  height: 170.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              valueKey: 'seeTopRatedMovies',
              text: 'Phim được yêu thích',
              onSeeMoreTapped: () => Navigator.pushNamed(
                context,
                TopRatedMoviesPage.routeName,
              ),
            ),
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              if (data.topRatedMoviesState == RequestState.loaded) {
                return FadeIn(
                  duration: const Duration(milliseconds: 500),
                  child: HorizontalItemList(
                    movies: data.topRatedMovies,
                  ),
                );
              } else if (data.topRatedMoviesState == RequestState.error) {
                return const Center(child: Text('Load data failed'));
              } else {
                return SizedBox(
                  height: 170.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              valueKey: 'seeTop20Chinese',
              text: 'Top phim Trung Quốc',
              onSeeMoreTapped: () => Navigator.pushNamed(
                context,
                Top20ChineseMoviesPage.routeName,
              ),
            ),
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              if (data.top20ChineseMoviesState == RequestState.loaded) {
                return FadeIn(
                  duration: const Duration(milliseconds: 500),
                  child: HorizontalItemList(
                    movies: data.top20ChineseMovies,
                  ),
                );
              } else if (data.top20ChineseMoviesState == RequestState.error) {
                return const Center(child: Text('Load data failed'));
              } else {
                return SizedBox(
                  height: 170.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              valueKey: 'seeTopHqMovies',
              text: 'Top phim Hàn Quốc',
              onSeeMoreTapped: () => Navigator.pushNamed(
                context,
                TopHqMoviesPage.routeName,
              ),
            ),
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              if (data.topHqMoviesState == RequestState.loaded) {
                return FadeIn(
                  duration: const Duration(milliseconds: 500),
                  child: HorizontalItemList(
                    movies: data.topHqMovies,
                  ),
                );
              } else if (data.topHqMoviesState == RequestState.error) {
                return const Center(child: Text('Load data failed'));
              } else {
                return SizedBox(
                  height: 170.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              valueKey: 'seeTopAcMovies',
              text: 'Top phim Hành Động',
              onSeeMoreTapped: () => Navigator.pushNamed(
                context,
                TopAcMoviesPage.routeName,
              ),
            ),
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              if (data.topAcMoviesState == RequestState.loaded) {
                return FadeIn(
                  duration: const Duration(milliseconds: 500),
                  child: HorizontalItemList(
                    movies: data.topAcMovies,
                  ),
                );
              } else if (data.topAcMoviesState == RequestState.error) {
                return const Center(child: Text('Load data failed'));
              } else {
                return SizedBox(
                  height: 170.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
