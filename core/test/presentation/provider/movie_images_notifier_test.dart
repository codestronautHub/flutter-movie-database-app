import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/usecases/get_movie_images.dart';
import 'package:core/presentation/provider/movie_images_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_images_notifier_test.mocks.dart';

@GenerateMocks([GetMovieImages])
void main() {
  late int listenerCallCount;
  late MockGetMovieImages mockGetMovieImages;
  late MovieImagesNotifier provider;

  setUp(() {
    listenerCallCount = 0;
    mockGetMovieImages = MockGetMovieImages();
    provider = MovieImagesNotifier(getMovieImages: mockGetMovieImages)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tId = 1;

  group('movie images', () {
    test(
      'initial state should be empty',
      () {
        expect(provider.movieImagesState, equals(RequestState.empty));
      },
    );

    test(
      'should get movie images data from the usecase',
      () async {
        // arrange
        when(mockGetMovieImages.execute(tId))
            .thenAnswer((_) async => Right(testImages));

        // act
        await provider.fetchMovieImages(tId);

        // assert
        verify(mockGetMovieImages.execute(tId));
      },
    );

    test(
      'should change state to loading when usecase is called',
      () {
        // arrange
        when(mockGetMovieImages.execute(tId))
            .thenAnswer((_) async => Right(testImages));

        // act
        provider.fetchMovieImages(tId);

        // assert
        expect(provider.movieImagesState, equals(RequestState.loading));
        expect(listenerCallCount, equals(1));
      },
    );

    test(
      'should change movie images when data is gotten successfully',
      () async {
        // arrange
        when(mockGetMovieImages.execute(tId))
            .thenAnswer((_) async => Right(testImages));

        // act
        await provider.fetchMovieImages(tId);

        // assert
        expect(provider.movieImagesState, equals(RequestState.loaded));
        expect(provider.movieImages, equals(testImages));
        expect(listenerCallCount, equals(2));
      },
    );

    test(
      'should return server failure when error',
      () async {
        // arrange
        when(mockGetMovieImages.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server failure')));

        // act
        await provider.fetchMovieImages(tId);

        // assert
        expect(provider.movieImagesState, equals(RequestState.error));
        expect(provider.message, equals('Server failure'));
        expect(listenerCallCount, equals(2));
      },
    );
  });
}
