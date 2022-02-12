import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_images.dart';

import '../../helpers/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late GetMovieImages usecase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieImages(mockMovieRepository);
  });

  const tId = 1;

  test(
    'should get movie images from the repository',
    () async {
      // arrange
      when(mockMovieRepository.getMovieImages(tId))
          .thenAnswer((_) async => const Right(testImages));

      // act
      final result = await usecase.execute(tId);

      // assert
      expect(result, equals(const Right(testImages)));
    },
  );
}
