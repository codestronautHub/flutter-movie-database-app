import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailNotifier])
void main() {
  late MockTvDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'watchlist button should display add icon when tv not added to watchlist',
    (WidgetTester tester) async {
      // arrange
      // act
      // assert
    },
  );

  testWidgets(
    'watchlist button should display check icon when tv is added to watchlist',
    (WidgetTester tester) async {
      // arrange
      // act
      // assert
    },
  );

  testWidgets(
    'watchlist button should display snackbar when tv is added to watchlist',
    (WidgetTester tester) async {
      // arrange
      // act
      // assert
    },
  );

  testWidgets(
    'watchlist button should display alert dialog when add to watchlist failed',
    (WidgetTester tester) async {
      // arrange
      // act
      // assert
    },
  );
}
