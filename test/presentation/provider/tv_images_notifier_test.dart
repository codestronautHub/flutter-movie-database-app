import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_images.dart';
import 'package:ditonton/presentation/provider/tv_images_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_images_notifier_test.mocks.dart';

@GenerateMocks([GetTvImages])
void main() {
  late int listenerCallCount;
  late MockGetTvImages mockGetTvImages;
  late TvImagesNotifier provider;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvImages = MockGetTvImages();
    provider = TvImagesNotifier(getTvImages: mockGetTvImages)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tId = 1;

  group('tv images', () {
    test(
      'initial state should be empty',
      () {
        expect(provider.tvImagesState, equals(RequestState.Empty));
      },
    );

    test(
      'should get tv images data from the usecase',
      () async {
        // arrange
        when(mockGetTvImages.execute(tId))
            .thenAnswer((_) async => Right(testImages));

        // act
        await provider.fetchTvImages(tId);

        // assert
        verify(mockGetTvImages.execute(tId));
      },
    );

    test('should change state to loading when the usecase is called', () {
      // arrange
      when(mockGetTvImages.execute(tId))
          .thenAnswer((_) async => Right(testImages));

      // act
      provider.fetchTvImages(tId);

      // assert
      expect(provider.tvImagesState, equals(RequestState.Loading));
      expect(listenerCallCount, equals(1));
    });

    test(
      'should change tv images when data is gotten successfully',
      () async {
        // arrange
        when(mockGetTvImages.execute(tId))
            .thenAnswer((_) async => Right(testImages));

        // act
        await provider.fetchTvImages(tId);

        // assert
        expect(provider.tvImagesState, equals(RequestState.Loaded));
        expect(provider.tvImages, equals(testImages));
        expect(listenerCallCount, equals(2));
      },
    );

    test(
      'should return server failure when error',
      () async {
        // arrange
        when(mockGetTvImages.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server failure')));

        // act
        await provider.fetchTvImages(tId);

        // assert
        expect(provider.tvImagesState, equals(RequestState.Error));
        expect(provider.message, equals('Server failure'));
        expect(listenerCallCount, equals(2));
      },
    );
  });
}
