import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/watchlist_tv_provider.dart';
import '../widgets/item_card_list.dart';

class TvWatchlist extends StatelessWidget {
  const TvWatchlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistTvNotifier>(
      builder: (context, data, child) {
        if (data.watchlistState == RequestState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (data.watchlistState == RequestState.loaded) {
          return ListView.builder(
            key: const Key('tvWatchlist'),
            itemCount: data.watchlistTvs.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              final tv = data.watchlistTvs[index];
              return ItemCard(
                tv: tv,
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
