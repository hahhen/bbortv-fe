import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:window_manager/window_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  });

  runApp(const MyApp());
}

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
        child: Column(
          children: [
            Container(
                child: Stack(
              children: [
                Image.network(
                    "https://images.unsplash.com/photo-1580757468214-c73f7062a5cb?fm=jpg&w=3000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8MTYlM0E5fGVufDB8fDB8fHww"),
                Positioned(
                    child: Expanded(
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
                ))),
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
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("YARTHI II: BREAKTHROUGH",
                                      style: TextStyle(
                                          height: 1,
                                          fontSize: 45,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -3.5)),
                                  Text("BRAIN BUREAU OF RESEARCH NO.1",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.8)),
                                ],
                              ),
                            ),
                            const Text(
                                "The sequence to the highly acclaimed debut album by Hahhen: Yarthi. Explores a grief thematic, surrounded by ambience and melancholy. It’s a deep dive into Kanye West’s 2018 album run, containing songs from Ye, Kids See Ghosts, Daytona and more.",
                                style: TextStyle(
                                  height: 1.2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                )),
                          ],
                        ))),
              ],
            )),
            const Padding(padding: EdgeInsets.all(30.0), child: Category())
          ],
        ),
      ),
    );
  }
}

class Video extends StatelessWidget {
  const Video({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(14.0),
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/Aspect_ratio_-_16x9.svg/2560px-Aspect_ratio_-_16x9.svg.png",
                  width: 240,
                  height: 135,
                )),
          ),
          const Text(
            "Yarthi II: Breakthrough",
            style: TextStyle(fontSize: 14, height: 1, letterSpacing: -0.5),
          ),
          const Text("2024", style: TextStyle(fontSize: 12))
        ],
      ),
    );
  }
}

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State createState() => _CategoryState();
}

class _CategoryState extends State {
  final _future = Supabase.instance.client.from('bureau').select();
  @override
  Widget build(BuildContext context) {
    print('size is ');
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
              ListTile(
                title: Text(bureau['name']),
              );
              // return Column(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 20.0),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(bottom: 10.0),
              //             child: Text(
              //               bureau['name'],
              //               style: const TextStyle(
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w700,
              //                   letterSpacing: -0.5),
              //             ),
              //           ),
              //           const Row(
              //             children: [Video()],
              //           )
              //         ],
              //       ),
              //     )
              //   ],
              // );
            }),
          );
        });
  }
}
