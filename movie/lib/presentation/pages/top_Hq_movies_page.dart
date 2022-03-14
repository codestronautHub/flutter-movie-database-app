import 'package:animate_do/animate_do.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/top_Hq_movies_notifier.dart';
import '../widgets/item_card_list.dart';

class TopHqMoviesPage extends StatefulWidget {
  static const routeName = '/top-usuk-movies';

  const TopHqMoviesPage({Key? key}) : super(key: key);

  @override
  _TopHqMoviesPageState createState() => _TopHqMoviesPageState();
}

class _TopHqMoviesPageState extends State<TopHqMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopHqMoviesNotifier>(context, listen: false)
            .fetchTopHqMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Top phim Hàn Quốc'),
        backgroundColor: Colors.black.withOpacity(0.6),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopHqMoviesNotifier>(
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
                  key: const Key('topHqMovies'),
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
