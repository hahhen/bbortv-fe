import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
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
      home: Scaffold(
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
              Column(
                children: [
                  Positioned(
                      left: 0.0,
                      top: 100.0,
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          child: const Column(
                            children: [
                              Text("YARTHI II: BREAKTHROUGH",
                                  style: TextStyle(
                                      height: 1,
                                      fontSize: 45,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -3.5)),
                              Text(
                                  "BRAIN BUREAU OF RESEARCH NO.1",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.8))
                            ],
                          ))),
                  Image.network(
                      "https://images.unsplash.com/photo-1580757468214-c73f7062a5cb?fm=jpg&w=3000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8MTYlM0E5fGVufDB8fDB8fHww"),
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
