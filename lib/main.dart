import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:window_manager/window_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bbortv_fe/highlight.dart';
import 'package:bbortv_fe/video.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://mxxapptkrnqawvtwltoq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im14eGFwcHRrcm5xYXd2dHdsdG9xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjA4Mzk3OTIsImV4cCI6MjAzNjQxNTc5Mn0.oqMINF-zKAfen-3a5omHXifeeIJEg60VOqc7icrNfP0',
  );

  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setAspectRatio(16 / 9);
  });

  runApp(const MyApp());
}

ScrollController scrollController = ScrollController();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            colorScheme: const ColorScheme.dark(),
            scaffoldBackgroundColor: Colors.black,
            fontFamily: 'Nimbus Sans L',
            textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: 'Nimbus Sans L',
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                )),
        debugShowCheckedModeBanner: false,
        home: const Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State createState() => _HomeState();
}

class _HomeState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 65,
        actions: [
          Expanded(
              child: Container(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(children: [
                    const Text("BBORTV",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700)),
                    Expanded(child: MoveWindow())
                  ]))),
          MinimizeWindowButton(
              colors: WindowButtonColors(iconNormal: Colors.white)),
          MaximizeWindowButton(
              colors: WindowButtonColors(iconNormal: Colors.white)),
          CloseWindowButton(
              colors: WindowButtonColors(iconNormal: Colors.white)),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: const Column(
          children: [
            Highlight(),
            Padding(padding: EdgeInsets.symmetric(horizontal: 30), child: Category())
          ],
        ),
      ),
    );
  }
}

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
