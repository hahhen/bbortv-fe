import 'package:flutter/material.dart';
import 'package:bbortv_fe/components/highlight.dart';
import 'package:bbortv_fe/components/category.dart';
import 'package:bbortv_fe/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _future = Supabase.instance.client
      .from('video')
      .select('id, name, bureau(name), sinopsis, thumbnail')
      .order('release_date', ascending: false)
      .limit(1);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final highlight = snapshot.data![0];
                return Highlight(videoId: highlight['id']);
              }),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30), child: Category()),
        ],
      ),
    );
  }
}
