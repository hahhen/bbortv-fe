import 'package:bbortv_fe/components/searchedvideos.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? _searchPattern;

  @override
  void initState() {
    super.initState();
  }

  void updateSearchPattern(String value) {
    setState(() {
      _searchPattern = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 70.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
                hintText: 'Search for videos',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            onChanged: (value) => {updateSearchPattern(value)},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:20.0),
            child: SearchedVideos(pattern: _searchPattern ?? ""),
          ),
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
