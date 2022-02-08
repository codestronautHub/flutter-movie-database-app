import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class HomeRobot {
  final WidgetTester tester;
  HomeRobot(this.tester);

  Future<void> clickNavigationDrawerButton() async {
    final drawerButtonFinder = find.byKey(const Key('drawerButton'));

    await tester.ensureVisible(drawerButtonFinder);
    await tester.tap(drawerButtonFinder);

    await tester.pumpAndSettle();
  }

  Future<void> clickSearchButton() async {
    final searchButtonFinder = find.byKey(const Key('searchButton'));

    await tester.ensureVisible(searchButtonFinder);
    await tester.tap(searchButtonFinder);

    await tester.pumpAndSettle();
  }

  Future<void> clickMovieListTile() async {
    final movieListTileFinder = find.byKey(const Key('movieListTile'));

    await tester.ensureVisible(movieListTileFinder);
    await tester.tap(movieListTileFinder);

    await tester.pumpAndSettle();
  }

  Future<void> clickTvListTile() async {
    final tvListTileFinder = find.byKey(const Key('tvListTile'));

    await tester.ensureVisible(tvListTileFinder);
    await tester.tap(tvListTileFinder);

    await tester.pumpAndSettle();
  }

  Future<void> clickWatchlistListTile() async {
    final watchlistListTileFinder = find.byKey(const Key('watchlistListTile'));

    await tester.ensureVisible(watchlistListTileFinder);
    await tester.tap(watchlistListTileFinder);

    await tester.pumpAndSettle();
  }

  Future<void> clickAboutListTile() async {
    final aboutListTileFinder = find.byKey(const Key('aboutListTile'));

    await tester.ensureVisible(aboutListTileFinder);
    await tester.tap(aboutListTileFinder);

    await tester.pumpAndSettle();
  }

  Future<void> clickCloseDrawerButton() async {
    final closeDrawerButtonFinder = find.byKey(const Key('closeDrawerButton'));

    await tester.ensureVisible(closeDrawerButtonFinder);
    await tester.tap(closeDrawerButtonFinder);

    await tester.pumpAndSettle();
  }

  Future<void> scrollMoviePage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('movieScrollView'));

    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 500), 10000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -500), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> scrollTvPage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('tvScrollView'));

    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 500), 10000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -500), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> clickSeePopularMovies() async {
    final seePopularMoviesButtonFinder =
        find.byKey(const Key('seePopularMovies'));

    await tester.ensureVisible(seePopularMoviesButtonFinder);
    await tester.tap(seePopularMoviesButtonFinder);

    await tester.pumpAndSettle();
  }

  Future<void> clickSeeTopRatedMovies() async {
    final seeTopRatedMoviesButtonFinder =
        find.byKey(const Key('seeTopRatedMovies'));

    await tester.ensureVisible(seeTopRatedMoviesButtonFinder);
    await tester.tap(seeTopRatedMoviesButtonFinder);

    await tester.pumpAndSettle();
  }

  Future<void> clickSeePopularTvs() async {
    final seePopularTvsButtonFinder = find.byKey(const Key('seePopularTvs'));

    await tester.ensureVisible(seePopularTvsButtonFinder);
    await tester.tap(seePopularTvsButtonFinder);

    await tester.pumpAndSettle();
  }

  Future<void> clickSeeTopRatedTvs() async {
    final seeTopRatedTvsButtonFinder = find.byKey(const Key('seeTopRatedTvs'));

    await tester.ensureVisible(seeTopRatedTvsButtonFinder);
    await tester.tap(seeTopRatedTvsButtonFinder);

    await tester.pumpAndSettle();
  }

  Future<void> clickMovieItem() async {
    final movieItemFinder = find.byKey(const Key('openMovieMinimalDetail'));

    await tester.ensureVisible(movieItemFinder);
    await tester.tap(movieItemFinder);

    await tester.pumpAndSettle();
  }

  Future<void> closeMovieMinimalDetail() async {
    final closeMovieMinimalDetailButtonFinder =
        find.byKey(const Key('closeMovieMinimalDetail'));

    await tester.ensureVisible(closeMovieMinimalDetailButtonFinder);
    await tester.tap(closeMovieMinimalDetailButtonFinder);

    await tester.pumpAndSettle();
  }

  Future<void> clickSeeMoreMovieDetail() async {
    final seeMoreMovieDetailButtonFinder =
        find.byKey(const Key('goToMovieDetail'));

    await tester.ensureVisible(seeMoreMovieDetailButtonFinder);
    await tester.tap(seeMoreMovieDetailButtonFinder);

    await tester.pumpAndSettle();
  }

  Future<void> clickTvItem() async {
    final tvItemFinder = find.byKey(const Key('openTvMinimalDetail'));

    await tester.ensureVisible(tvItemFinder);
    await tester.tap(tvItemFinder);

    await tester.pumpAndSettle();
  }

  Future<void> closeTvMinimalDetail() async {
    final closeTvMinimalDetailButtonFinder =
        find.byKey(const Key('closeTvMinimalDetail'));

    await tester.ensureVisible(closeTvMinimalDetailButtonFinder);
    await tester.tap(closeTvMinimalDetailButtonFinder);

    await tester.pumpAndSettle();
  }

  Future<void> clickSeeMoreTvDetail() async {
    final seeMoreTvDetailButtonFinder = find.byKey(const Key('goToTvDetail'));

    await tester.ensureVisible(seeMoreTvDetailButtonFinder);
    await tester.tap(seeMoreTvDetailButtonFinder);

    await tester.pumpAndSettle();
  }
}
