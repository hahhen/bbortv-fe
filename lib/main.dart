import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/widgets.dart';
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
              Container(
                child: Column(children: [
                  Column(children: [
                    const Text("BRAIN BUREAU OF RESEARCH NO.1"),
                    Row(
                      children: [
                        Column(
                          children: [
                            Image.network("https://i9.ytimg.com/vi/7I7-6EVqWAk/mqdefault.jpg?sqp=COyux7QG-oaymwEmCMACELQB8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGEggSChyMA8=&rs=AOn4CLCY3KK738CfhD-R5fGsGC42Aadw3Q", width: 160, height: 90,),
                            const Text("YARTHI II: BREAKTHROUGH"),
                            const Text("2024")
                          ],
                        )
                      ],
                    )
                  ],)
                ],),
              )
            ],
          ),
        ),
      ),
    );
  }
}
