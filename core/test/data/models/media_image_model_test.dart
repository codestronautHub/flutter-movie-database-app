import 'dart:convert';

import 'package:core/data/models/media_image_model.dart';
import 'package:core/domain/entities/media_image.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tMediaImageModel = MediaImageModel(
    id: 1,
    backdropPaths: ['/path.jpg'],
    logoPaths: ['/path.png'],
    posterPaths: ['/path.jpg'],
  );

  const tMediaImage = MediaImage(
    id: 1,
    backdropPaths: ['/path.jpg'],
    logoPaths: ['/path.png'],
    posterPaths: ['/path.jpg'],
  );

  group('to entity', () {
    test(
      'should be a subclass of media image entity',
      () async {
        // act
        final result = tMediaImageModel.toEntity();

        // assert
        expect(result, equals(tMediaImage));
      },
    );
  });

  group('from json', () {
    test('should return a valid model from json', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('dummy_data/media_images.json'),
      );

      // act
      final result = MediaImageModel.fromJson(jsonMap);

      // assert
      expect(result, equals(tMediaImageModel));
    });
  });
}
