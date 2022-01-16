import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:ditonton/presentation/provider/tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
    genreIds: [16, 10765, 10759, 18],
    id: 94605,
    name: 'Arcane',
    overview:
        'Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.',
    posterPath: '/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg',
    voteAverage: 9.1,
    voteCount: 1451,
  );

  final tTvList = <Tv>[tTv];

  final tQuery = 'Arcane';

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
        expect(provider.state, equals(RequestState.Loading));
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
        expect(provider.state, equals(RequestState.Loaded));
        expect(provider.searchResult, equals(tTvList));
        expect(listenerCallCount, equals(2));
      },
    );

    test(
      'shoudl return server failure when error',
      () async {
        // arrange
        when(mockSearchTvs.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server failure')));

        // act
        await provider.fetchTvSearch(tQuery);

        // assert
        expect(provider.state, equals(RequestState.Error));
        expect(provider.message, equals('Server failure'));
        expect(listenerCallCount, equals(2));
      },
    );
  });
}
