import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
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
      when(mockNotifier.state).thenReturn(RequestState.Loading);

      // act
      final centerFinder = find.byType(Center);
      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      // assert
      expect(centerFinder, equals(findsOneWidget));
      expect(progressBarFinder, equals(findsOneWidget));
    },
  );

  testWidgets(
    'page should display list view when data is loaded',
    (WidgetTester tester) async {
      // arrange
      when(mockNotifier.state).thenReturn(RequestState.Loaded);
      when(mockNotifier.movies).thenReturn(<Movie>[]);

      // act
      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      // assert
      expect(listViewFinder, equals(findsOneWidget));
    },
  );

  testWidgets(
    'page should display text with message when error',
    (WidgetTester tester) async {
      // arrange
      when(mockNotifier.state).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn('Error message');

      // act
      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      // assert
      expect(textFinder, equals(findsOneWidget));
    },
  );
}
