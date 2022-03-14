import 'package:core/presentation/provider/home_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie/data/datasources/db/movie_database_helper.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_movie_watchlist_status.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top20_chinese_movies.dart';
import 'package:movie/domain/usecases/get_top_Ac_movies.dart';
import 'package:movie/domain/usecases/get_top_Hq_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/remove_watchlist_movie.dart';
import 'package:movie/domain/usecases/save_watchlist_movie.dart';
import 'package:movie/presentation/provider/movie_detail_notifier.dart';
import 'package:movie/presentation/provider/movie_list_notifier.dart';
import 'package:movie/presentation/provider/popular_movies_notifier.dart';
import 'package:movie/presentation/provider/top20_chinese_movies_notifier.dart';
import 'package:movie/presentation/provider/top_Ac_movies_notifier.dart';
import 'package:movie/presentation/provider/top_Hq_movies_notifier.dart';
import 'package:movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tvs.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:tv/data/datasources/db/tv_database_helper.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:tv/domain/usecases/get_on_the_air_tvs.dart';
import 'package:tv/domain/usecases/get_popular_tvs.dart';
import 'package:tv/domain/usecases/get_top_Tq_tvs.dart';
import 'package:tv/domain/usecases/get_top_rated_tvs.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/get_tv_watchlist_status.dart';
import 'package:tv/domain/usecases/get_watchlist_tvs.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:tv/presentation/provider/popular_tvs_notifier.dart';
import 'package:tv/presentation/provider/top_rated_tvs_notifier.dart';
import 'package:tv/presentation/provider/top_tq_tvs_notifier.dart';
import 'package:tv/presentation/provider/tv_detail_notifier.dart';
import 'package:tv/presentation/provider/tv_list_notifier.dart';
import 'package:tv/presentation/provider/watchlist_tv_provider.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => MovieSearchBloc(locator()));
  locator.registerFactory(() => TvSearchBloc(locator()));

  // provider
  locator.registerFactory(() => HomeNotifier());

  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
      getTop20ChineseMovies: locator(),
      getTopHqMovies: locator(),
      getTopAcMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => Top20ChineseMoviesNotifier(
      getTop20ChineseMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TopHqMoviesNotifier(
      getTopHqMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TopAcMoviesNotifier(
      getTopAcMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TvListNotifier(
      getOnTheAirTvs: locator(),
      getPopularTvs: locator(),
      getTopRatedTvs: locator(),
      getTopTqTvs: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopTqTvsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvNotifier(
      getWatchlistTvs: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetTop20ChineseMovies(locator()));
  locator.registerLazySingleton(() => GetTopHqMovies(locator()));
  locator.registerLazySingleton(() => GetTopAcMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetOnTheAirTvs(locator()));
  locator.registerLazySingleton(() => GetPopularTvs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvs(locator()));
  locator.registerLazySingleton(() => GetTopTqTvs(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));

  locator.registerLazySingleton(
    () => GetMovieWatchlistStatus(
      movieRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetTvWatchlistStatus(
      tvRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SaveWatchlistMovie(
      movieRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SaveWatchlistTv(
      tvRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => RemoveWatchlistMovie(
      movieRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => RemoveWatchlistTv(
      tvRepository: locator(),
    ),
  );

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
    () => TvLocalDataSourceImpl(databaseHelper: locator()),
  );

  // helper
  locator.registerLazySingleton<MovieDatabaseHelper>(
    () => MovieDatabaseHelper(),
  );
  locator.registerLazySingleton<TvDatabaseHelper>(
    () => TvDatabaseHelper(),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
