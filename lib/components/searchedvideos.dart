import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bbortv_fe/main.dart';
import 'package:bbortv_fe/pages/videolandingpage.dart';

class SearchedVideos extends StatefulWidget {
  final String pattern;
  const SearchedVideos({super.key, required this.pattern});

  @override
  State<SearchedVideos> createState() => _SearchedVideosState();
}

class _SearchedVideosState extends State<SearchedVideos> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pattern = widget.pattern;
    final Future future = Supabase.instance.client.from('video').select().ilike('name', '%$pattern%');
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final videos = snapshot.data!;
          return SizedBox(
            height: 176,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: videos.length,
                itemBuilder: ((context, index) {
                  final video = videos[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: TextButton(
                        style: ButtonStyle(
                            foregroundColor:
                                WidgetStateProperty.all(Colors.white),
                            splashFactory: NoSplash.splashFactory,
                            overlayColor:
                                WidgetStateProperty.all(Colors.transparent),
                            padding: WidgetStateProperty.all(EdgeInsets.zero)),
                        onPressed: () => context.read<CurrentPage>().updatePage(
                            VideoLandingPage(
                                key: UniqueKey(), videoId: video['id'])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14.0),
                                  child: Image.network(
                                    video['thumbnail'],
                                    width: 240,
                                    height: 135,
                                  )),
                            ),
                            Text(
                              video['name'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  height: 1,
                                  letterSpacing: -0.5),
                            ),
                            Text(video['release_date'],
                                style: const TextStyle(fontSize: 12))
                          ],
                        )),
                  );
                })),
          );
        });
  }
}
