import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bbortv_fe/main.dart';

class Highlight extends StatefulWidget {
  final int videoId;
  const Highlight({super.key, required this.videoId});

  @override
  State<Highlight> createState() => _HighlightState();
}

class _HighlightState extends State<Highlight> {
  late Future _future;

  final int a = 2;
  
  @override
  void initState() {
    super.initState();
    _future = Supabase.instance.client
        .from('video')
        .select('name, bureau(name), sinopsis, thumbnail')
        .match({'id': widget.videoId});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final highlight = snapshot.data![0];
          return Stack(
            children: [
              Image.network(
                highlight['thumbnail'],
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color.fromARGB(0, 0, 0, 0),
                          Color.fromARGB(255, 0, 0, 0)
                        ])),
                  )),
              Positioned(
                  bottom: 70.0,
                  left: 0.0,
                  child: Container(
                      width: 800,
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(highlight['name'],
                                    style: const TextStyle(
                                        height: 1,
                                        fontSize: 45,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -3.5)),
                                Text(highlight['bureau']['name'],
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.8)),
                              ],
                            ),
                          ),
                          Text(highlight['sinopsis']??'',
                              style: const TextStyle(
                                height: 1.2,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      ))),
              Positioned.fill(
                bottom: 30,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: IconButton(
                        onPressed: () {
                          scrollController.animateTo(
                              MediaQuery.of(context).size.height,
                              duration: const Duration(seconds: 1),
                              curve: Curves.ease);
                        },
                        icon: const Icon(Icons.keyboard_arrow_down))),
              )
            ],
          );
        });
  }
}
