import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late TvLocalDataSourceImpl dataSource;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test(
      'should return success message when data has been inserted to database',
      () async {
        // arrange
        when(mockDatabaseHelper.insertTvWatchlist(testTvTable))
            .thenAnswer((_) async => 1);

        // act
        final result = await dataSource.insertWatchlist(testTvTable);

        // assert
        expect(result, equals('Added to watchlist'));
      },
    );

    test(
      'should throw database exception when insert to database is failed',
      () async {
        // arrange
        when(mockDatabaseHelper.insertTvWatchlist(testTvTable))
            .thenThrow(Exception());

        // act
        final call = dataSource.insertWatchlist(testTvTable);

        // assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      },
    );
  });

  group('remove watchlist', () {
    test(
      'should return success message when data has been removed from database',
      () async {
        // arrange
        when(mockDatabaseHelper.removeTvWatchlist(testTvTable))
            .thenAnswer((_) async => 1);

        // act
        final result = await dataSource.removeWatchlist(testTvTable);

        // assert
        expect(result, 'Removed from watchlist');
      },
    );

    test(
      'should throw database exception when remove from database is failed',
      () async {
        // arrange
        when(mockDatabaseHelper.removeTvWatchlist(testTvTable))
            .thenThrow(Exception());

        // act
        final call = dataSource.removeWatchlist(testTvTable);

        // assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      },
    );
  });
}
