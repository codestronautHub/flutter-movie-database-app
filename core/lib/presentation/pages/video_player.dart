// ignore_for_file: directives_ordering

import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool isLoop;
  const VideoPlayer({
    Key? key,
    required this.videoPlayerController,
    required this.isLoop,
  }) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late ChewieController chewieController;
  @override
  void initState() {
    chewieController = ChewieController(
        looping: widget.isLoop,
        aspectRatio: 16 / 9,
        autoInitialize: true,
        autoPlay: true,
        videoPlayerController: widget.videoPlayerController);
    super.initState();
  }

  @override
  void dispose() {
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(controller: chewieController),
    );
  }
}

class VideoDisplay extends StatefulWidget {
  final String videoUrl;

  const VideoDisplay({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoDisplayState createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<VideoDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color.fromARGB(248, 1, 0, 3),
      body: VideoPlayer(
          isLoop: true,
          videoPlayerController:
              VideoPlayerController.network(widget.videoUrl)),
    );
  }
}
