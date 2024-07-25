import 'package:bbortv_fe/pages/videolandingpage.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:bbortv_fe/main.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

class Player extends StatefulWidget {
  final int videoId;
  final String src;
  const Player({super.key, required this.videoId, required this.src});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  late int videoId;

  @override
  void initState() {
    initializePlayer();
    super.initState();
    videoId = widget.videoId;
  }

  Future initializePlayer() async {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.src));
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      allowFullScreen: false,
      allowMuting: false,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null
        ? Stack(
          children: [
            Theme(
                data: ThemeData.light().copyWith(
                  platform: TargetPlatform.iOS,
                ),
                child: Chewie(
                  controller: _chewieController!,
                )),
          ],
        )
        : const Center(child: CircularProgressIndicator());
  }
}
