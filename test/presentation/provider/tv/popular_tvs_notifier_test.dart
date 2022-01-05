import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/presentation/provider/popular_tvs_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tvs_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvs])
void main() {
  late int listenerCallCount;
  late MockGetPopularTvs mockGetPopularTvs;
  late PopularTvsNotifier notifier;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvs = MockGetPopularTvs();
    notifier = PopularTvsNotifier(mockGetPopularTvs)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTv = Tv(
    backdropPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    genreIds: [1, 2, 3, 4],
    id: 1,
    name: 'Name',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvList = <Tv>[tTv];

  test(
    'should change state to loading when usecase is called',
    () async {
      // arrange
      when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right(tTvList));

      // act
      notifier.fetchPopularTvs();

      // assert
      expect(notifier.state, equals(RequestState.Loading));
      expect(listenerCallCount, equals(1));
    },
  );

  test(
    'should change tvs when data is gotten successfully',
    () async {
      // arrange
      when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right(tTvList));

      // act
      await notifier.fetchPopularTvs();

      // assert
      expect(notifier.state, equals(RequestState.Loaded));
      expect(notifier.tvs, equals(tTvList));
      expect(listenerCallCount, equals(2));
    },
  );

  test(
    'should return server failure when error',
    () async {
      // arrange
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server failure')));

      // act
      await notifier.fetchPopularTvs();

      // assert
      expect(notifier.state, equals(RequestState.Error));
      expect(notifier.message, equals('Server failure'));
      expect(listenerCallCount, equals(2));
    },
  );
}
