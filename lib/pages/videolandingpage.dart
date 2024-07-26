import 'package:bbortv_fe/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:bbortv_fe/components/highlight.dart';
import 'package:bbortv_fe/components/category.dart';
import 'package:bbortv_fe/main.dart';
import 'package:provider/provider.dart';

class VideoLandingPage extends StatelessWidget {
  final int videoId;
  const VideoLandingPage({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          Stack(
            children: [
              Highlight(
                videoId: videoId,
              ),
              Positioned(
                  top: 60,
                  left: 25,
                  child: TextButton(
                      style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all(Colors.white),
                          splashFactory: NoSplash.splashFactory,
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                          padding: WidgetStateProperty.all(EdgeInsets.zero)),
                      onPressed: () =>
                          context.read<CurrentPage>().updatePage(const Home()),
                      child: const Row(
                        children: [
                          Icon(Icons.chevron_left),
                          Text("Go back to home"),
                        ],
                      ))),
            ],
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30), child: Category()),
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: [
                Text("© 2024 Brain Bureau Of Research"),
                Text("v0.0.1")
              ],
            ),
          )
        ],
      ),
    );
  }
}
