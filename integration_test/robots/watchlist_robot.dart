import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class WatchlistRobot {
  final WidgetTester tester;
  WatchlistRobot(this.tester);

  Future<void> clickMovieWatchlistTab() async {
    final movieWatchlistTabFinder = find.byKey(const Key('movieWatchlistTab'));

    await tester.ensureVisible(movieWatchlistTabFinder);
    await tester.tap(movieWatchlistTabFinder);

    await tester.pumpAndSettle();

    final movieWatchlist = find.byKey(const Key('movieWatchlist'));

    expect(movieWatchlist, equals(findsOneWidget));
  }

  Future<void> clickTvWatchlistTab() async {
    final tvWatchlistTabFinder = find.byKey(const Key('tvWatchlistTab'));

    await tester.ensureVisible(tvWatchlistTabFinder);
    await tester.tap(tvWatchlistTabFinder);

    await tester.pumpAndSettle();

    final tvWatchlist = find.byKey(const Key('tvWatchlist'));

    expect(tvWatchlist, equals(findsOneWidget));
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }
}
