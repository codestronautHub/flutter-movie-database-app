import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/urls.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_season_episodes_notifier.dart';
import 'package:ditonton/presentation/widgets/minimal_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-detail';

  final int id;
  TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvDetailNotifier>(context, listen: false)
          .fetchTvDetail(widget.id);
      Provider.of<TvDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
      Provider.of<TvSeasonEpisodesNotifier>(context, listen: false)
          .fetchTvSeasonEpisodes(widget.id, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvState == RequestState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.tvState == RequestState.Loaded) {
            final tv = provider.tv;
            return TvDetailContent(
              tv: tv,
              seasonNumber: tv.numberOfSeasons,
              recommendations: provider.recommendations,
              isAddedToWatchlist: provider.isAddedToWatchlist,
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class TvDetailContent extends StatefulWidget {
  final TvDetail tv;
  final int seasonNumber;
  final List<Tv> recommendations;
  final bool isAddedToWatchlist;
  const TvDetailContent({
    required this.tv,
    required this.seasonNumber,
    required this.recommendations,
    required this.isAddedToWatchlist,
  });

  @override
  State<TvDetailContent> createState() => _TvDetailContentState();
}

class _TvDetailContentState extends State<TvDetailContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  List<int> _seasons = [];
  int _currentSeason = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    for (int i = 1; i <= widget.seasonNumber; i++) {
      _seasons.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            background: FadeIn(
              child: ShaderMask(
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
                    stops: [0.0, 0.5, 1.0, 1.0],
                  ).createShader(
                    Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                  );
                },
                blendMode: BlendMode.dstIn,
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width,
                  imageUrl: Urls.imageUrl(widget.tv.backdropPath!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: FadeInUp(
            from: 20,
            duration: Duration(milliseconds: 500),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tv.name,
                    style: kHeading5.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          widget.tv.firstAirDate.split('-')[0],
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20.0,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            (widget.tv.voteAverage / 2).toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            '(${widget.tv.voteAverage})',
                            style: TextStyle(
                              fontSize: 1.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16.0),
                      Text(
                        '${widget.tv.numberOfSeasons} Seasons',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Text(
                        _showEpisodeDuration(widget.tv.episodeRunTime[0]),
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (!widget.isAddedToWatchlist) {
                        await Provider.of<TvDetailNotifier>(context,
                                listen: false)
                            .addToWatchlist(widget.tv);
                      } else {
                        await Provider.of<TvDetailNotifier>(context,
                                listen: false)
                            .removeFromWatchlist(widget.tv);
                      }

                      final message =
                          Provider.of<TvDetailNotifier>(context, listen: false)
                              .watchlistMessage;

                      if (message ==
                              TvDetailNotifier.watchlistAddSuccessMessage ||
                          message ==
                              TvDetailNotifier.watchlistRemoveSuccessMessage) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(message)));
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(message),
                            );
                          },
                        );
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        widget.isAddedToWatchlist
                            ? Icon(Icons.check, color: Colors.white)
                            : Icon(Icons.add, color: Colors.black),
                        SizedBox(width: 16.0),
                        Text(
                          widget.isAddedToWatchlist
                              ? 'Added to watchlist'
                              : 'Add to watchlist',
                          style: TextStyle(
                            color: widget.isAddedToWatchlist
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: widget.isAddedToWatchlist
                          ? Colors.grey[850]
                          : Colors.white,
                      minimumSize: Size(
                        MediaQuery.of(context).size.width,
                        42.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    widget.tv.overview,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Genres: ${_showGenres(widget.tv.genres)}',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(bottom: 16.0),
          sliver: SliverToBoxAdapter(
            child: FadeIn(
              duration: Duration(milliseconds: 500),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.redAccent,
                      style: BorderStyle.solid,
                      width: 4.0,
                    ),
                  ),
                ),
                tabs: [
                  Tab(text: 'Episodes'.toUpperCase()),
                  Tab(text: 'More like this'.toUpperCase()),
                ],
              ),
            ),
          ),
        ),
        Builder(builder: (context) {
          _tabController.addListener(() {
            if (!_tabController.indexIsChanging) {
              setState(() {
                _selectedIndex = _tabController.index;
              });
            }
          });

          return _selectedIndex == 0
              ? SliverPadding(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                  sliver: SliverToBoxAdapter(
                    child: FadeIn(
                      duration: Duration(milliseconds: 500),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<int>(
                              onChanged: (value) {
                                setState(() {
                                  _currentSeason = value!;
                                });

                                Provider.of<TvSeasonEpisodesNotifier>(
                                  context,
                                  listen: false,
                                ).fetchTvSeasonEpisodes(
                                  widget.tv.id,
                                  _currentSeason,
                                );
                              },
                              items: _seasons
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          'Season $item',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ))
                                  .toList(),
                              value: _currentSeason,
                              style: new TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : SliverToBoxAdapter();
        }),
        Builder(builder: (context) {
          _tabController.addListener(() {
            if (!_tabController.indexIsChanging) {
              setState(() {
                _selectedIndex = _tabController.index;
              });
            }
          });

          return _selectedIndex == 0
              ? SliverPadding(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
                  sliver: _showSeasonEpisodes(),
                )
              : SliverPadding(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
                  sliver: _showRecommendations(),
                );
        }),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    genres.forEach((genre) {
      result += genre.name + ', ';
    });

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showEpisodeDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Widget _showRecommendations() {
    return Consumer<TvDetailNotifier>(
      builder: (context, data, child) {
        if (data.recommendationsState == RequestState.Loaded) {
          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final recommendation = data.recommendations[index];
                return FadeInUp(
                  from: 20,
                  duration: Duration(milliseconds: 500),
                  child: GestureDetector(
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
                            type: MdbContentType.Tv,
                            tv: recommendation,
                          );
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      child: CachedNetworkImage(
                        imageUrl: Urls.imageUrl(recommendation.posterPath!),
                        placeholder: (context, url) => Shimmer.fromColors(
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
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        height: 180.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              childCount: data.recommendations.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.7,
              crossAxisCount:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? 3
                      : 4,
            ),
          );
        } else if (data.recommendationsState == RequestState.Error) {
          return SliverToBoxAdapter(child: Center(child: Text(data.message)));
        } else {
          return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _showSeasonEpisodes() {
    return Consumer<TvSeasonEpisodesNotifier>(
      builder: (context, data, child) {
        if (data.seasonEpisodesState == RequestState.Loaded) {
          return data.seasonEpisodes.isEmpty
              ? SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Comming Soon!',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final seasonEpisode = data.seasonEpisodes[index];
                      return FadeInUp(
                        from: 20,
                        duration: Duration(milliseconds: 500),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: Urls.imageUrl(
                                            seasonEpisode.stillPath!),
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 200.0,
                                          child: Text(
                                            '${seasonEpisode.episodeNumber}. ${seasonEpisode.name}',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          DateFormat('MMM dd, yyyy').format(
                                            DateTime.parse(
                                                seasonEpisode.airDate),
                                          ),
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12.0,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  seasonEpisode.overview,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 10.0,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: data.seasonEpisodes.length,
                  ),
                );
        }
        if (data.seasonEpisodesState == RequestState.Error) {
          return SliverToBoxAdapter(child: Center(child: Text(data.message)));
        } else {
          return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
