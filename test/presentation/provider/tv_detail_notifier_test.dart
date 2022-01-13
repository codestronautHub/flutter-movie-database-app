import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late int listenerCallCount;
  late MockGetTvDetail mockGetTvDetail;
  late TvDetailNotifier provider;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    provider = TvDetailNotifier(
      getTvDetail: mockGetTvDetail,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  final tId = 1;

  // final tTv = Tv(
  //   backdropPath: '/path.jpg',
  //   firstAirDate: '2022-01-01',
  //   genreIds: [1, 2, 3, 4],
  //   id: 1,
  //   name: 'Name',
  //   originalName: 'Original Name',
  //   overview: 'Overview',
  //   popularity: 1.0,
  //   posterPath: '/path.jpg',
  //   voteAverage: 1.0,
  //   voteCount: 1,
  // );

  // final tTvs = <Tv>[tTv];

  void _arrangeUsecase() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvDetail));
  }

  group('tv detail', () {
    test(
      'should get tv detail data from the usecase',
      () async {
        // arrange
        _arrangeUsecase();

        // act
        await provider.fetchTvDetail(tId);

        // assert
        verify(mockGetTvDetail.execute(tId));
      },
    );

    test(
      'should change state to loading when usecase is called',
      () {
        // arrange
        _arrangeUsecase();

        // act
        provider.fetchTvDetail(tId);

        // assert
        expect(provider.tvState, equals(RequestState.Loading));
        expect(listenerCallCount, equals(1));
      },
    );

    test(
      'should change tv data is gotten successfully',
      () async {
        // arrange
        _arrangeUsecase();

        // act
        await provider.fetchTvDetail(tId);

        // assert
        expect(provider.tvState, equals(RequestState.Loaded));
        expect(provider.tv, equals(testTvDetail));
        expect(listenerCallCount, equals(2));
      },
    );

    test(
      'should change recommendation tvs when data is gotten successfully',
      () async {
        // TODO: Add tv recommendations
      },
    );

    test(
      'should return server failure when error',
      () async {
        // arrange
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server failure')));

        // act
        await provider.fetchTvDetail(tId);

        // assert
        expect(provider.tvState, equals(RequestState.Error));
        expect(provider.message, equals('Server failure'));
        expect(listenerCallCount, equals(2));
      },
    );
  });
}
