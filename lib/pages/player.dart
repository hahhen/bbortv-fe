import 'dart:ui';

import 'package:bbortv_fe/pages/videolandingpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:bbortv_fe/main.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:chewie/src/notifiers/index.dart';

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
  late PlayerNotifier notifier;
  Timer? _hideTimer;
  IconData volumeIcon = CupertinoIcons.volume_up;

  @override
  void initState() {
    initializePlayer();
    super.initState();
    videoId = widget.videoId;
    notifier = Provider.of<PlayerNotifier>(context, listen: false);
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

  void _cancelAndRestartTimer() {
    _hideTimer?.cancel();

    setState(() {
      notifier.hideStuff = false;

      _startHideTimer();
    });
  }

  void _startHideTimer() {
    final hideControlsTimer = _chewieController!.hideControlsTimer.isNegative
        ? ChewieController.defaultHideControlsTimer
        : _chewieController?.hideControlsTimer;
    _hideTimer = Timer(hideControlsTimer!, () {
      setState(() {
        notifier.hideStuff = true;
      });
    });
  }

  void _chewieUpdateVolume(double volume) {
    _videoPlayerController.setVolume(volume);
    setState(() {
      if (_videoPlayerController.value.volume == 0) {
        volumeIcon = CupertinoIcons.volume_mute;
      } else if (_videoPlayerController.value.volume < 0.5) {
        volumeIcon = CupertinoIcons.volume_down;
      } else if (_videoPlayerController.value.volume > 0.5) {
        volumeIcon = CupertinoIcons.volume_up;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null
        ? Listener(
            onPointerMove: (_) => _cancelAndRestartTimer(),
            onPointerDown: (_) => _cancelAndRestartTimer(),
            onPointerHover: (_) => _cancelAndRestartTimer(),
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
                      opacity: notifier.hideStuff ? 0.0 : 1.0,
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
                    )),
                Positioned(
                    right: 5,
                    bottom: 60,
                    child: AnimatedOpacity(
                        opacity: notifier.hideStuff ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  color: const Color.fromARGB(181, 41, 41, 41),
                                  child: Row(
                                    children: [
                                      Icon(
                                        volumeIcon,
                                        color: Colors.white60,
                                        size: 20,
                                      ),
                                      SliderTheme(
                                          data: const SliderThemeData(
                                              trackHeight: 3,
                                              activeTrackColor: Colors.white70,
                                              inactiveTrackColor:
                                                  Colors.white10,
                                              overlayShape:
                                                  RoundSliderOverlayShape(
                                                      overlayRadius: 15),
                                              thumbShape: RoundSliderThumbShape(
                                                  enabledThumbRadius: 7)),
                                          child: Slider(
                                              value: _videoPlayerController
                                                  .value.volume,
                                              onChanged: (value) => {
                                                    _chewieUpdateVolume(value)
                                                  })),
                                    ],
                                  ),
                                )))))
              ],
            ))
        : const Center(child: CircularProgressIndicator());
  }
}
