import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_movie_images.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late GetMovieImages usecase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieImages(mockMovieRepository);
  });

  final tId = 1;

  test(
    'should get movie images from the repository',
    () async {
      // arrange
      when(mockMovieRepository.getMovieImages(tId))
          .thenAnswer((_) async => Right(testMovieImages));

      // act
      final result = await usecase.execute(tId);

      // assert
      expect(result, equals(Right(testMovieImages)));
    },
  );
}
