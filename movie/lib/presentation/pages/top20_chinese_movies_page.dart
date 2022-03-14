import 'package:animate_do/animate_do.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/top20_chinese_movies_notifier.dart';
import '../provider/top_rated_movies_notifier.dart';
import '../widgets/item_card_list.dart';

class Top20ChineseMoviesPage extends StatefulWidget {
  static const routeName = '/top-20chinese-movies';

  const Top20ChineseMoviesPage({Key? key}) : super(key: key);

  @override
  _Top20ChineseMoviesPageState createState() => _Top20ChineseMoviesPageState();
}

class _Top20ChineseMoviesPageState extends State<Top20ChineseMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<Top20ChineseMoviesNotifier>(context, listen: false)
            .fetchTop20ChineseMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Top phim Trung Quốc'),
        backgroundColor: Colors.black.withOpacity(0.6),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<Top20ChineseMoviesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return FadeInUp(
                from: 20,
                duration: const Duration(milliseconds: 500),
                child: ListView.builder(
                  key: const Key('topChineseMovies'),
                  itemBuilder: (context, index) {
                    final movie = data.movies[index];
                    return ItemCard(
                      movie: movie,
                    );
                  },
                  itemCount: data.movies.length,
                ),
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
