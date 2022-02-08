import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:core/presentation/provider/popular_movies_notifier.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMoviesNotifier])
void main() {
  late MockPopularMoviesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockPopularMoviesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PopularMoviesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'page should display center progress bar when loading',
    (WidgetTester tester) async {
      // arrange
      when(mockNotifier.state).thenReturn(RequestState.loading);

      // act
      final centerFinder = find.byType(Center);
      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

      // assert
      expect(centerFinder, equals(findsOneWidget));
      expect(progressBarFinder, equals(findsOneWidget));
    },
  );

  testWidgets(
    'page should display list view when data is loaded',
    (WidgetTester tester) async {
      // arrange
      when(mockNotifier.state).thenReturn(RequestState.loaded);
      when(mockNotifier.movies).thenReturn(<Movie>[]);

      // act
      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(
        _makeTestableWidget(const PopularMoviesPage()),
        const Duration(milliseconds: 500),
      );
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // assert
      expect(listViewFinder, equals(findsOneWidget));
    },
  );

  testWidgets(
    'page should display text with message when error',
    (WidgetTester tester) async {
      // arrange
      when(mockNotifier.state).thenReturn(RequestState.error);
      when(mockNotifier.message).thenReturn('Error message');

      // act
      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(
        _makeTestableWidget(const PopularMoviesPage()),
        const Duration(milliseconds: 500),
      );
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // assert
      expect(textFinder, equals(findsOneWidget));
    },
  );
}
