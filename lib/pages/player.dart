import 'package:bbortv_fe/pages/videolandingpage.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:bbortv_fe/main.dart';
import 'package:provider/provider.dart';

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
  double opacity = 0;

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
        ? Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (_) {
              if (opacity == 0) {
                setState(() {
                  opacity = 1;
                });
              }
            },
            onPointerHover: (_) {
              if (opacity == 0) {
                setState(() {
                  opacity = 1;
                });
              }
            },
            child: Stack(
              children: [
                Theme(
                    data: ThemeData.light().copyWith(
                      platform: TargetPlatform.iOS,
                    ),
                    child: Chewie(
                      controller: _chewieController!,
                    )),
                Positioned(
                    top: 60,
                    left: 10,
                    child: AnimatedOpacity(
                      opacity: opacity,
                      duration: const Duration(milliseconds: 300),
                      child: TextButton(
                        child: const Row(
                          children: [
                            Icon(
                              Icons.arrow_back,
                              size: 10,
                            ),
                            SizedBox(width: 5),
                            Text("Go back to this video's page",
                                style: TextStyle(fontSize: 10)),
                          ],
                        ),
                        onPressed: () => {
                          context
                              .read<CurrentPage>()
                              .updatePage(VideoLandingPage(videoId: videoId))
                        },
                      ),
                    ))
              ],
            ))
        : const Center(child: CircularProgressIndicator());
  }
}
