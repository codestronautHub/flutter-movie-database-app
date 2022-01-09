import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/image.dart';
import 'package:ditonton/domain/usecases/get_movie_images.dart';
import 'package:ditonton/presentation/provider/movie_images_notifier.dart';
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

  final tMovieImages = Image(
    id: 1,
    backdropPaths: ['/path.jpg'],
    logoPaths: ['/path.jpg'],
    posterPaths: ['/path.jpg'],
  );

  group('movie images', () {
    test(
      'should get movie images data from the usecase',
      () async {
        // arrange
        when(mockGetMovieImages.execute(tId))
            .thenAnswer((_) async => Right(testMovieImages));

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
            .thenAnswer((_) async => Right(testMovieImages));

        // act
        provider.fetchMovieImages(tId);

        // assert
        expect(provider.movieImagesState, equals(RequestState.Loading));
        expect(listenerCallCount, equals(1));
      },
    );

    test(
      'should change movie images when data is gotten successfully',
      () async {
        // arrange
        when(mockGetMovieImages.execute(tId))
            .thenAnswer((_) async => Right(testMovieImages));

        // act
        await provider.fetchMovieImages(tId);

        // assert
        expect(provider.movieImagesState, equals(RequestState.Loaded));
        expect(provider.movieImages, equals(testMovieImages));
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
        expect(provider.movieImagesState, equals(RequestState.Error));
        expect(provider.message, equals('Server failure'));
        expect(listenerCallCount, equals(2));
      },
    );
  });
}
