import 'package:flutter/material.dart';
import 'package:bbortv_fe/components/highlight.dart';
import 'package:bbortv_fe/components/category.dart';
import 'package:bbortv_fe/main.dart';

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
                
                Highlight( videoId: videoId,),
              ],
            ),
            
            const Padding(padding: EdgeInsets.symmetric(horizontal: 30), child: Category())
          ],
        ),
    );
  }
}