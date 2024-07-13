import 'package:flutter/material.dart';
import 'package:bbortv_fe/components/highlight.dart';
import 'package:bbortv_fe/components/category.dart';
import 'package:bbortv_fe/main.dart';

class VideoLandingPage extends StatelessWidget {
  const VideoLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        controller: scrollController,
        child: const Column(
          children: [
            Highlight(),
            Padding(padding: EdgeInsets.symmetric(horizontal: 30), child: Category())
          ],
        ),
    );
  }
}