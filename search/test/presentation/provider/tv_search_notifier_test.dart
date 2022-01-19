import 'package:core/domain/entities/tv.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tvs.dart';
import 'package:search/presentation/provider/tv_search_notifier.dart';

import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late int listenerCallCount;
  late MockSearchTvs mockSearchTvs;
  late TvSearchNotifier provider;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvs = MockSearchTvs();
    provider = TvSearchNotifier(searchTvs: mockSearchTvs)
      ..addListener(() {
        listenerCallCount++;
      });
  });

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

  const tQuery = 'Arcane';

  group('search a tv', () {
    test(
      'should change state to loading when usecase is called',
      () async {
        // arrange
        when(mockSearchTvs.execute(tQuery))
            .thenAnswer((_) async => Right(tTvList));

        // act
        provider.fetchTvSearch(tQuery);

        // assert
        expect(provider.state, equals(RequestState.loading));
      },
    );

    test(
      'should change search result when data is gotten successfully',
      () async {
        // arrange
        when(mockSearchTvs.execute(tQuery))
            .thenAnswer((_) async => Right(tTvList));

        // act
        await provider.fetchTvSearch(tQuery);

        // assert
        expect(provider.state, equals(RequestState.loaded));
        expect(provider.searchResult, equals(tTvList));
        expect(listenerCallCount, equals(2));
      },
    );

    test(
      'shoudl return server failure when error',
      () async {
        // arrange
        when(mockSearchTvs.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failure')));

        // act
        await provider.fetchTvSearch(tQuery);

        // assert
        expect(provider.state, equals(RequestState.error));
        expect(provider.message, equals('Server failure'));
        expect(listenerCallCount, equals(2));
      },
    );
  });
}
