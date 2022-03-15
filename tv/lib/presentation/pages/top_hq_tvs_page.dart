import 'package:animate_do/animate_do.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/top_hq_tvs_notifier.dart';
import '../widgets/item_card_list.dart';

class TopHqTvsPage extends StatefulWidget {
  static const routeName = '/top-hq-tvs';

  const TopHqTvsPage({Key? key}) : super(key: key);

  @override
  _TopHqTvsPageState createState() => _TopHqTvsPageState();
}

class _TopHqTvsPageState extends State<TopHqTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopHqTvsNotifier>(context, listen: false)
            .fetchTopHqTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Seri top phim Hàn Quốc'),
        backgroundColor: Colors.black.withOpacity(0.6),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopHqTvsNotifier>(
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
                  key: const Key('topHqTvsListView'),
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
