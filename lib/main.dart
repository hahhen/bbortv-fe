import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:window_manager/window_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bbortv_fe/pages/home.dart';

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
        home: const Layout());
  }
}

class Layout extends StatefulWidget {  
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late Widget activePage;

  @override
  void initstate(){
    super.initState();
    activePage = const Home();
  }
  void callback(Widget nextPage) {
    setState(() {
      activePage = nextPage;
    });
  }

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
      body: const Home(),
    );
  }
}
