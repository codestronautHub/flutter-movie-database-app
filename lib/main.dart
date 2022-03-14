import 'dart:io';

import 'package:about/about.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:core/presentation/provider/home_notifier.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top20_chinese_movies_page.dart';
import 'package:movie/presentation/pages/top_Ac_movies_page.dart';
import 'package:movie/presentation/pages/top_Hq_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie/presentation/provider/movie_detail_notifier.dart';
import 'package:movie/presentation/provider/movie_list_notifier.dart';
import 'package:movie/presentation/provider/popular_movies_notifier.dart';
import 'package:movie/presentation/provider/top20_chinese_movies_notifier.dart';
import 'package:movie/presentation/provider/top_Ac_movies_notifier.dart';
import 'package:movie/presentation/provider/top_Hq_movies_notifier.dart';
import 'package:movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/pages/tv_search_page.dart';
import 'package:search/search.dart';
import 'package:tv/presentation/pages/popular_tvs_page.dart';
import 'package:tv/presentation/pages/top_rated_tvs_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/provider/popular_tvs_notifier.dart';
import 'package:tv/presentation/provider/top_rated_tvs_notifier.dart';
import 'package:tv/presentation/provider/tv_detail_notifier.dart';
import 'package:tv/presentation/provider/tv_list_notifier.dart';
import 'package:tv/presentation/provider/watchlist_tv_provider.dart';

import 'injection.dart' as di;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// General
        ChangeNotifierProvider(
          create: (_) => di.locator<HomeNotifier>(),
        ),

        /// Movie
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<Top20ChineseMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopHqMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopAcMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),

        /// Tv
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvNotifier>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Movie Database App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(
            secondary: Colors.redAccent,
          ),
        ),
        home: const HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomePage());
            case PopularMoviesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case Top20ChineseMoviesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const Top20ChineseMoviesPage());
            case TopHqMoviesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const TopHqMoviesPage());
            case TopAcMoviesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const TopAcMoviesPage());
            case MovieDetailPage.routeName:
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: settings.arguments as int),
                settings: settings,
              );
            case PopularTvsPage.routeName:
              return MaterialPageRoute(builder: (_) => const PopularTvsPage());
            case TopRatedTvsPage.routeName:
              return MaterialPageRoute(builder: (_) => const TopRatedTvsPage());
            case TvDetailPage.routeName:
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: settings.arguments as int),
                settings: settings,
              );
            case MovieSearchPage.routeName:
              return MaterialPageRoute(builder: (_) => const MovieSearchPage());
            case TvSearchPage.routeName:
              return MaterialPageRoute(builder: (_) => const TvSearchPage());
            case WatchlistPage.routeName:
              return MaterialPageRoute(builder: (_) => const WatchlistPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
