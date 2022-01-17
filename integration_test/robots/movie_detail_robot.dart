import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MovieDetailRobot {
  final WidgetTester tester;
  MovieDetailRobot(this.tester);

  Future<void> clickMovieToWatchlistButton() async {
    final movieToWatchlistButtonFinder = find.byKey(Key('movieToWatchlist'));

    await tester.ensureVisible(movieToWatchlistButtonFinder);
    await tester.tap(movieToWatchlistButtonFinder);

    await tester.pumpAndSettle();
  }

  Future<void> scrollThePage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(Key('movieDetailScrollView'));

    if (scrollUp) {
      await tester.fling(scrollViewFinder, Offset(0, 500), 10000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(scrollViewFinder, Offset(0, -500), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
    sleep(Duration(seconds: 2));
  }
}
