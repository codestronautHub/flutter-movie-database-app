import 'package:animate_do/animate_do.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/top_ac_tvs_notifier.dart';
import '../widgets/item_card_list.dart';

class TopAcTvsPage extends StatefulWidget {
  static const routeName = '/top-ac-tvs';

  const TopAcTvsPage({Key? key}) : super(key: key);

  @override
  _TopAcTvsPageState createState() => _TopAcTvsPageState();
}

class _TopAcTvsPageState extends State<TopAcTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopAcTvsNotifier>(context, listen: false)
            .fetchTopAcTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Top seri phim Hành động'),
        backgroundColor: Colors.black.withOpacity(0.6),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopAcTvsNotifier>(
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
                  key: const Key('topAcTvsListView'),
                  itemCount: data.tvs.length,
                  itemBuilder: (context, index) {
                    final tv = data.tvs[index];
                    return ItemCard(tv: tv);
                  },
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
