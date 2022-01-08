import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/urls.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tvs_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tvs_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/home_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Provider.of<HomeNotifier>(context, listen: false)
                    .setState(ContentType.Movie);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Tv Show'),
              onTap: () {
                Provider.of<HomeNotifier>(context, listen: false)
                    .setState(ContentType.Tv);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About'),
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'MDB',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colors.black.withOpacity(0.0),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
          )
        ],
      ),
      body: Consumer<HomeNotifier>(builder: (context, data, child) {
        final state = data.state;
        if (state == ContentType.Movie) {
          return MainMoviePage();
        } else {
          return MainTvPage();
        }
      }),
    );
  }
}

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
        ..fetchTopRatedMovies(),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kHeading6),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('See More'),
                Icon(Icons.arrow_forward_ios, size: 16.0)
              ],
            ),
          ),
        ),
      ],
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
              final state = data.nowPlayingState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 520.0,
                    autoPlay: true,
                    viewportFraction: 1.0,
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
                                Text(
                                  'Now Playing'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  item.title!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Detail'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    minimumSize: Size(
                                      100.0,
                                      36.0,
                                    ),
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
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
            SizedBox(height: 32.0),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(
                context,
                PopularMoviesPage.ROUTE_NAME,
              ),
            ),
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              final state = data.popularMoviesState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return HorizontalItemList(
                  type: ContentType.Movie,
                  movies: data.popularMovies,
                );
              } else {
                return Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(
                context,
                TopRatedMoviesPage.ROUTE_NAME,
              ),
            ),
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              final state = data.topRatedMoviesState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return HorizontalItemList(
                  type: ContentType.Movie,
                  movies: data.topRatedMovies,
                );
              } else {
                return Text('Failed');
              }
            }),
          ],
        ),
      ),
    );
  }
}

class MainTvPage extends StatefulWidget {
  @override
  _MainTvPageState createState() => _MainTvPageState();
}

class _MainTvPageState extends State<MainTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<TvListNotifier>(context, listen: false)
        ..fetchOnTheAirTvs()
        ..fetchPopularTvs()
        ..fetchTopRatedTvs(),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kHeading6),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('See More'),
                Icon(Icons.arrow_forward_ios, size: 16.0)
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('On The Air', style: kHeading6),
              Consumer<TvListNotifier>(builder: (context, data, child) {
                final state = data.onTheAirTvsState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return HorizontalItemList(
                    type: ContentType.Tv,
                    tvs: data.onTheAirTvs,
                  );
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                  context,
                  PopularTvsPage.ROUTE_NAME,
                ),
              ),
              Consumer<TvListNotifier>(builder: (context, data, child) {
                final state = data.popularTvsState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return HorizontalItemList(
                    type: ContentType.Tv,
                    tvs: data.popularTvs,
                  );
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                  context,
                  TopRatedTvsPage.ROUTE_NAME,
                ),
              ),
              Consumer<TvListNotifier>(builder: (context, data, child) {
                final state = data.topRatedTvsState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return HorizontalItemList(
                    type: ContentType.Tv,
                    tvs: data.topRatedTvs,
                  );
                } else {
                  return Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

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
            itemCount: movies!.length,
            itemBuilder: (context, index) {
              final movie = movies![index];
              return Container(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MovieDetailPage.ROUTE_NAME,
                      arguments: movie.id,
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
          height: 200.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tvs!.length,
            itemBuilder: (context, index) {
              final tv = tvs![index];
              return Container(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MovieDetailPage.ROUTE_NAME,
                      arguments: tv.id,
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
