import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/watchlist_movie_notifier.dart';
import '../widgets/item_card_list.dart';

class MovieWatchlist extends StatelessWidget {
  const MovieWatchlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistMovieNotifier>(
      builder: (context, data, child) {
        if (data.watchlistState == RequestState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (data.watchlistState == RequestState.loaded) {
          return ListView.builder(
            key: const Key('movieWatchlist'),
            itemCount: data.watchlistMovies.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              final movie = data.watchlistMovies[index];
              return ItemCard(
                movie: movie,
              );
            },
          );
        } else {
          return Center(
            key: const Key('error_message'),
            child: Text(data.message),
          );
        }
      },
    );
  }
}
