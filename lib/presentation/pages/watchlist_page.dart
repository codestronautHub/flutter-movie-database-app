import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_provider.dart';
import 'package:ditonton/presentation/widgets/item_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
    Future.microtask(() =>
        Provider.of<WatchlistTvNotifier>(context, listen: false)
            .fetchWatchlistTvs());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvNotifier>(context, listen: false)
        .fetchWatchlistTvs();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          bottom: TabBar(
            tabs: [
              Tab(
                key: Key('movieWatchlistTab'),
                text: 'Move',
              ),
              Tab(
                key: Key('tvWatchlistTab'),
                text: 'Tv',
              ),
            ],
            indicatorColor: Colors.redAccent,
            indicatorWeight: 4.0,
          ),
        ),
        body: TabBarView(
          children: [
            Consumer<WatchlistMovieNotifier>(
              builder: (context, data, child) {
                if (data.watchlistState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (data.watchlistState == RequestState.Loaded) {
                  return ListView.builder(
                    key: Key('movieWatchlist'),
                    itemCount: data.watchlistMovies.length,
                    padding: EdgeInsets.all(16.0),
                    itemBuilder: (context, index) {
                      final movie = data.watchlistMovies[index];
                      return ItemCard(
                        type: MdbContentType.Movie,
                        movie: movie,
                      );
                    },
                  );
                } else {
                  return Center(
                    key: Key('error_message'),
                    child: Text(data.message),
                  );
                }
              },
            ),
            Consumer<WatchlistTvNotifier>(
              builder: (context, data, child) {
                if (data.watchlistState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (data.watchlistState == RequestState.Loaded) {
                  return ListView.builder(
                    key: Key('tvWatchlist'),
                    itemCount: data.watchlistTvs.length,
                    padding: EdgeInsets.all(16.0),
                    itemBuilder: (context, index) {
                      final tv = data.watchlistTvs[index];
                      return ItemCard(
                        type: MdbContentType.Tv,
                        tv: tv,
                      );
                    },
                  );
                } else {
                  return Center(
                    key: Key('error_message'),
                    child: Text(data.message),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
