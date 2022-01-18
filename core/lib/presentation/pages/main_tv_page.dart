import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/core.dart';
import 'package:core/presentation/pages/popular_tvs_page.dart';
import 'package:core/presentation/pages/top_rated_tvs_page.dart';
import 'package:core/presentation/provider/tv_images_notifier.dart';
import 'package:core/presentation/provider/tv_list_notifier.dart';
import 'package:core/presentation/widgets/horizontal_item_list.dart';
import 'package:core/presentation/widgets/minimal_detail.dart';
import 'package:core/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MainTvPage extends StatefulWidget {
  @override
  _MainTvPageState createState() => _MainTvPageState();
}

class _MainTvPageState extends State<MainTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvListNotifier>(context, listen: false)
          .fetchOnTheAirTvs()
          .whenComplete(
            () => Provider.of<TvImagesNotifier>(context, listen: false)
                .fetchTvImages(
                    Provider.of<TvListNotifier>(context, listen: false)
                        .onTheAirTvs[0]
                        .id),
          );
      Provider.of<TvListNotifier>(context, listen: false).fetchPopularTvs();
      Provider.of<TvListNotifier>(context, listen: false).fetchTopRatedTvs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        key: Key('tvScrollView'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<TvListNotifier>(builder: (context, data, child) {
              if (data.onTheAirTvsState == RequestState.loaded) {
                return FadeIn(
                  duration: Duration(milliseconds: 500),
                  child: CarouselSlider(
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
                        return GestureDetector(
                          key: Key('openTvMinimalDetail'),
                          onTap: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return MinimalDetail(
                                  keyValue: 'goToTvDetail',
                                  closeKeyValue: 'closeTvMinimalDetail',
                                  type: MdbContentType.tv,
                                  tv: item,
                                );
                              },
                            );
                          },
                          child: Stack(
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
                                    Rect.fromLTRB(
                                        0, 0, rect.width, rect.height),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                              RequestState.loaded) {
                                            if (data
                                                .tvImages.logoPaths.isEmpty) {
                                              return Text(item.name!);
                                            }
                                            return CachedNetworkImage(
                                              width: 200.0,
                                              imageUrl: Urls.imageUrl(
                                                data.tvImages.logoPaths[0],
                                              ),
                                            );
                                          } else if (data.tvImagesState ==
                                              RequestState.error) {
                                            return Center(
                                              child: Text('Load data failed'),
                                            );
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                );
              } else if (data.onTheAirTvsState == RequestState.error) {
                return Center(child: Text('Load data failed'));
              } else {
                return ShaderMask(
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
                  child: Shimmer.fromColors(
                    child: Container(
                      height: 575.0,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black,
                    ),
                    baseColor: Colors.grey[850]!,
                    highlightColor: Colors.grey[800]!,
                  ),
                );
              }
            }),
            SubHeading(
              valueKey: 'seePopularTvs',
              text: 'Popular',
              onSeeMoreTapped: () => Navigator.pushNamed(
                context,
                PopularTvsPage.ROUTE_NAME,
              ),
            ),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              if (data.popularTvsState == RequestState.loaded) {
                return FadeIn(
                  duration: Duration(milliseconds: 500),
                  child: HorizontalItemList(
                    type: MdbContentType.tv,
                    tvs: data.popularTvs,
                  ),
                );
              } else if (data.popularTvsState == RequestState.error) {
                return Center(child: Text('Load data failed'));
              } else {
                return Container(
                  height: 170.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Shimmer.fromColors(
                          child: Container(
                            height: 170.0,
                            width: 120.0,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          baseColor: Colors.grey[850]!,
                          highlightColor: Colors.grey[800]!,
                        ),
                      );
                    },
                  ),
                );
              }
            }),
            SubHeading(
              valueKey: 'seeTopRatedTvs',
              text: 'Top Rated',
              onSeeMoreTapped: () => Navigator.pushNamed(
                context,
                TopRatedTvsPage.ROUTE_NAME,
              ),
            ),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              if (data.topRatedTvsState == RequestState.loaded) {
                return FadeIn(
                  duration: Duration(milliseconds: 500),
                  child: HorizontalItemList(
                    type: MdbContentType.tv,
                    tvs: data.topRatedTvs,
                  ),
                );
              } else if (data.topRatedTvsState == RequestState.error) {
                return Center(child: Text('Load data failed'));
              } else {
                return Container(
                  height: 170.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Shimmer.fromColors(
                          child: Container(
                            height: 170.0,
                            width: 120.0,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          baseColor: Colors.grey[850]!,
                          highlightColor: Colors.grey[800]!,
                        ),
                      );
                    },
                  ),
                );
              }
            }),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
