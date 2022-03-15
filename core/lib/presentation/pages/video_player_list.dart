// ignore_for_file: directives_ordering

import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/entities/url_movie.dart';
import 'video_player.dart';

// ignore: must_be_immutable
class VideoPlayerList extends StatefulWidget {
  final String url;
  final List<UrlMovie> listMovie;
  final TvDetail tv;
  late int indexMovie;
  VideoPlayerList({
    Key? key,
    required this.url,
    required this.tv,
    required this.listMovie,
  }) : super(key: key);
  List<BetterPlayerDataSource> createDataSet() {
    List<BetterPlayerDataSource> dataSourceList = [];
    for (var item in listMovie) {
      dataSourceList.add(
        BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          item.url,
        ),
      );
    }
    return dataSourceList;
  }

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayerList> {
  int pressed = -1;
  final GlobalKey<BetterPlayerPlaylistState> _betterPlayerPlaylistStateKey =
      GlobalKey();
  late BetterPlayerConfiguration _betterPlayerConfiguration;
  late BetterPlayerPlaylistConfiguration _betterPlayerPlaylistConfiguration;

  BetterPlayerPlaylistController? get _betterPlayerPlaylistController =>
      _betterPlayerPlaylistStateKey
          .currentState!.betterPlayerPlaylistController;

  _VideoPlayerState() {
    _betterPlayerConfiguration = const BetterPlayerConfiguration(
        aspectRatio: 16 / 9,
        fit: BoxFit.cover,
        autoPlay: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          controlBarColor: Colors.black12,
        ));

    // ignore: prefer_const_constructors
    _betterPlayerPlaylistConfiguration = BetterPlayerPlaylistConfiguration(
      loopVideos: false,
      nextVideoDelay: const Duration(seconds: 3),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.indexMovie = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 32, 32, 32),
      body: Column(
        children: [
          _showNewPlayer(widget.indexMovie),
          _listMovieItem(),
        ],
      ),
    );
  }

  Widget _listMovieItem() {
    return Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemCount: widget.createDataSet().length,
            itemBuilder: (_, int index) {
              bool data = pressed == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.indexMovie = index;
                    pressed = index;
                    _betterPlayerPlaylistController!.setupDataSource(index);
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 214, 211, 211),
                      ),
                      color: (data) ? Colors.grey[700] : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        SizedBox(
                            width: 80,
                            height: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: CachedNetworkImage(
                                imageUrl: widget.tv.vod_pic,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                height: 150.0,
                                fit: BoxFit.cover,
                              ),
                            )),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tv.vod_name.length > 30
                                  ? widget.tv.vod_name.substring(0, 30) + '...'
                                  : widget.tv.vod_name,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: Text(
                                widget.listMovie[index].name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ]),
                ),
              );
            }));
  }

  Widget _showNewPlayer(int index) {
    return BetterPlayerPlaylist(
      key: _betterPlayerPlaylistStateKey,
      betterPlayerConfiguration: _betterPlayerConfiguration,
      betterPlayerPlaylistConfiguration: _betterPlayerPlaylistConfiguration,
      betterPlayerDataSourceList: widget.createDataSet(),
    );
  }
}
