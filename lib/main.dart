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
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Nimbus Sans L',
        textTheme: Theme.of(context)
          .textTheme
          .apply(
            fontFamily: 'Nimbus Sans L',
            bodyColor: Colors.white, 
            displayColor: Colors.white
          )
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 50,
            actions: [
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                      child: Row(children: [
                        const Text("BBORTV" , style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                        Expanded(child: MoveWindow())
              ]))),
              MinimizeWindowButton(),
              MaximizeWindowButton(),
              CloseWindowButton(),
            ],
          )
      ),
    );
  }
}
