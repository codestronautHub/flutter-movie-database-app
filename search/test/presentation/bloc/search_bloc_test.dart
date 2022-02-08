import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tvs.dart';
import 'package:search/presentation/bloc/search_bloc.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTvs])
void main() {
  late MockSearchMovies mockSearchMovies;
  late MockSearchTvs mockSearchTvs;
  late MovieSearchBloc movieSearchBloc;
  late TvSearchBloc tvSearchBloc;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchTvs = MockSearchTvs();
    movieSearchBloc = MovieSearchBloc(mockSearchMovies);
    tvSearchBloc = TvSearchBloc(mockSearchTvs);
  });

  final tMovie = Movie(
    backdropPath: '/1Rr5SrvHxMXHu5RjKpaMba8VTzi.jpg',
    genreIds: const [28, 12, 878],
    id: 634649,
    overview:
        'Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.',
    posterPath: '/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
    releaseDate: '2021-12-15',
    title: 'Spider-Man: No Way Home',
    voteAverage: 8.4,
    voteCount: 3427,
  );

  final tMovieList = <Movie>[tMovie];

  const tMovieQuery = 'spiderman';

  final tTv = Tv(
    backdropPath: '/rkB4LyZHo1NHXFEDHl9vSD9r1lI.jpg',
    firstAirDate: '2021-11-06',
    genreIds: const [16, 10765, 10759, 18],
    id: 94605,
    name: 'Arcane',
    overview:
        'Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.',
    posterPath: '/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg',
    voteAverage: 9.1,
    voteCount: 1451,
  );

  final tTvList = <Tv>[tTv];

  const tTvQuery = 'Arcane';

  test('initial state should be empty', () {
    expect(movieSearchBloc.state, SearchEmpty());
  });

  blocTest<MovieSearchBloc, SearchState>(
    'should emit [loading, has data] when movie data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(tMovieQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tMovieQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      MovieSearchHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tMovieQuery));
    },
  );

  blocTest<MovieSearchBloc, SearchState>(
    'should emit [loading, error] when search movie is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(tMovieQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server failure')));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tMovieQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchError('Server failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tMovieQuery));
    },
  );

  blocTest<TvSearchBloc, SearchState>(
    'should emit [loading, has data] when tv data is gotten successfully',
    build: () {
      when(mockSearchTvs.execute(tTvQuery))
          .thenAnswer((_) async => Right(tTvList));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tTvQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      TvSearchHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tTvQuery));
    },
  );

  blocTest<TvSearchBloc, SearchState>(
    'should emit [loading, error] when search tv is unsuccessful',
    build: () {
      when(mockSearchTvs.execute(tTvQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server failure')));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tTvQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchError('Server failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tTvQuery));
    },
  );
}
