import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ditonton/common/urls.dart';
import 'package:ditonton/presentation/pages/popular_tvs_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tvs_page.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_images_notifier.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:ditonton/presentation/widgets/horizontal_item_list.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainTvPage extends StatefulWidget {
  @override
  _MainTvPageState createState() => _MainTvPageState();
}

class _MainTvPageState extends State<MainTvPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    Future.microtask(
      () => Provider.of<TvListNotifier>(context, listen: false)
        ..fetchOnTheAirTvs()
        ..fetchPopularTvs()
        ..fetchTopRatedTvs().whenComplete(() =>
            Provider.of<TvImagesNotifier>(context, listen: false).fetchTvImages(
                Provider.of<TvListNotifier>(context, listen: false)
                    .onTheAirTvs[0]
                    .id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<TvListNotifier>(builder: (context, data, child) {
              if (data.onTheAirTvsState == RequestState.Loading) {
                return Center(child: CircularProgressIndicator());
              } else if (data.onTheAirTvsState == RequestState.Loaded) {
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 575.0,
                    viewportFraction: 1.0,
                    onPageChanged: (index, _) {
                      Provider.of<TvImagesNotifier>(context, listen: false)
                          .fetchTvImages(data.onTheAirTvs[index].id);
                    },
                  ),
                  items: data.onTheAirTvs.map(
                    (item) {
                      return Stack(
                        children: [
                          ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black,
                                  Colors.black,
                                  Colors.transparent,
                                ],
                                stops: [0, 0.3, 0.5, 1],
                              ).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height),
                              );
                            },
                            blendMode: BlendMode.dstIn,
                            child: CachedNetworkImage(
                              height: 560.0,
                              imageUrl: Urls.imageUrl(item.backdropPath!),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Colors.redAccent,
                                        size: 16.0,
                                      ),
                                      SizedBox(width: 4.0),
                                      Text(
                                        'On The Air'.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 16.0),
                                  child: Consumer<TvImagesNotifier>(
                                    builder: (context, data, child) {
                                      if (data.tvImagesState ==
                                          RequestState.Loading) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (data.tvImagesState ==
                                          RequestState.Loaded) {
                                        if (data.tvImages.logoPaths.isEmpty) {
                                          return Text(item.name!);
                                        }
                                        return CachedNetworkImage(
                                          width: 200.0,
                                          imageUrl: Urls.imageUrl(
                                            data.tvImages.logoPaths[0],
                                          ),
                                        );
                                      } else if (data.tvImagesState ==
                                          RequestState.Empty) {
                                        return Text('Please wait');
                                      } else {
                                        return Text('Failed');
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                );
              } else {
                return Text('Failed');
              }
            }),
            SubHeading(
              text: 'Popular',
              onSeeMoreTapped: () => Navigator.pushNamed(
                context,
                PopularTvsPage.ROUTE_NAME,
              ),
            ),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.popularTvsState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return HorizontalItemList(
                  type: MdbContentType.Tv,
                  tvs: data.popularTvs,
                );
              } else {
                return Text('Failed');
              }
            }),
            SubHeading(
              text: 'Top Rated',
              onSeeMoreTapped: () => Navigator.pushNamed(
                context,
                TopRatedTvsPage.ROUTE_NAME,
              ),
            ),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.topRatedTvsState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return HorizontalItemList(
                  type: MdbContentType.Tv,
                  tvs: data.topRatedTvs,
                );
              } else {
                return Text('Failed');
              }
            }),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
