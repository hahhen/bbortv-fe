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
  final List? chapters;
  const Player(
      {super.key, required this.videoId, required this.src, this.chapters});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  late int videoId;
  late List chapters;
  late PlayerNotifier notifier;
  Timer? _hideTimer;
  IconData volumeIcon = CupertinoIcons.volume_up;

  @override
  void initState() {
    initializePlayer();
    super.initState();
    videoId = widget.videoId;
    notifier = Provider.of<PlayerNotifier>(context, listen: false);
    chapters = widget.chapters ?? [];
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
                                ))))),
                chapters.isNotEmpty
                    ? Positioned(
                        right: 5,
                        top: 80,
                        child: AnimatedOpacity(
                            opacity: notifier.hideStuff ? 0.0 : 1.0,
                            duration: const Duration(milliseconds: 300),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        padding: const EdgeInsets.all(10),
                                        color: const Color.fromARGB(
                                            181, 41, 41, 41),
                                        child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: chapters.length,
                                            itemBuilder: ((context, index) {
                                              final chapter = chapters[index];
                                              final seconds =
                                                  int.parse(chapter[0]);
                                              return TextButton(
                                                  style: const ButtonStyle(
                                                      shape: WidgetStatePropertyAll(
                                                          RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))))),
                                                  onPressed: () => {
                                                        _chewieController
                                                            ?.seekTo(Duration(
                                                                seconds:
                                                                    seconds))
                                                      },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8.0),
                                                    child: Column(
                                                      children: [
                                                        Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                "Chapter ${index + 1}",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white70))),
                                                        Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                "${(seconds ~/ 60) ~/ 60}:${(seconds ~/ 60) % 60}:${seconds % 60}",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white70))),
                                                        Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                chapter[1])),
                                                      ],
                                                    ),
                                                  ));
                                            })))))))
                    : Container()
              ],
            ))
        : const Center(child: CircularProgressIndicator());
  }
}
