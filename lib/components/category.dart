import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bbortv_fe/components/video.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final _future = Supabase.instance.client.from('bureau').select();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final bureaus = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: bureaus.length,
            itemBuilder: ((context, index) {
              final bureau = bureaus[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            bureau['name'],
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.5),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Video(
                              category: bureau['id'],
                            ))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
          );
        });
  }
}