import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/usecases/get_tv_images.dart';
import 'package:core/presentation/provider/tv_images_notifier.dart';
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

  const tId = 1;

  group('tv images', () {
    test(
      'initial state should be empty',
      () {
        expect(provider.tvImagesState, equals(RequestState.empty));
      },
    );

    test(
      'should get tv images data from the usecase',
      () async {
        // arrange
        when(mockGetTvImages.execute(tId))
            .thenAnswer((_) async => const Right(testImages));

        // act
        await provider.fetchTvImages(tId);

        // assert
        verify(mockGetTvImages.execute(tId));
      },
    );

    test('should change state to loading when the usecase is called', () {
      // arrange
      when(mockGetTvImages.execute(tId))
          .thenAnswer((_) async => const Right(testImages));

      // act
      provider.fetchTvImages(tId);

      // assert
      expect(provider.tvImagesState, equals(RequestState.loading));
      expect(listenerCallCount, equals(1));
    });

    test(
      'should change tv images when data is gotten successfully',
      () async {
        // arrange
        when(mockGetTvImages.execute(tId))
            .thenAnswer((_) async => const Right(testImages));

        // act
        await provider.fetchTvImages(tId);

        // assert
        expect(provider.tvImagesState, equals(RequestState.loaded));
        expect(provider.tvImages, equals(testImages));
        expect(listenerCallCount, equals(2));
      },
    );

    test(
      'should return server failure when error',
      () async {
        // arrange
        when(mockGetTvImages.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failure')));

        // act
        await provider.fetchTvImages(tId);

        // assert
        expect(provider.tvImagesState, equals(RequestState.error));
        expect(provider.message, equals('Server failure'));
        expect(listenerCallCount, equals(2));
      },
    );
  });
}
