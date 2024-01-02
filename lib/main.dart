import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: HomeScreen(),
    //   theme: ThemeData(
    //     primarySwatch: MaterialColor(0xFF009688FF,
    //       const {
    //         50: const Color(0xFF009688FF),
    //         100: const Color(0xFF009688FF),
    //         200: const Color(0xFF009688FF),
    //         300: const Color(0xFF009688FF),
    //         400: const Color(0xFF009688FF),
    //         500: const Color(0xFF009688FF),
    //         600: const Color(0xFF009688FF),
    //         700: const Color(0xFF009688FF),
    //         800: const Color(0xFF009688FF),
    //         900: const Color(0xFF009688FF),
    //       }
    //     ),
    //     brightness: Brightness.light,
    //     elevatedButtonTheme: ElevatedButtonThemeData(
    //       style: ElevatedButton.styleFrom(
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(10)
    //         ),
    //         backgroundColor: Colors.teal,
    //         foregroundColor: Colors.white
    //       )
    //     ),
    //     scaffoldBackgroundColor: Colors.grey,
    //     appBarTheme: AppBarTheme(
    //       backgroundColor: Colors.blueGrey,
    //       titleTextStyle: TextStyle(
    //         color: Colors.white,
    //         fontSize: 20,
    //         fontWeight: FontWeight.bold
    //       ),
    //       centerTitle: true
    //     ),
    //   ),
    //   darkTheme: ThemeData(
    //     brightness: Brightness.dark,
    //     elevatedButtonTheme: ElevatedButtonThemeData(
    //         style: ElevatedButton.styleFrom(
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(10)
    //             ),
    //             backgroundColor: Colors.teal,
    //             foregroundColor: Colors.white
    //         )
    //     ),
    //     appBarTheme: AppBarTheme(
    //         backgroundColor: Colors.blueGrey,
    //         titleTextStyle: TextStyle(
    //             color: Colors.white,
    //             fontSize: 20,
    //             fontWeight: FontWeight.bold
    //         ),
    //         centerTitle: true
    //     ),
    //   ),
    //   themeMode: ThemeMode.dark,
    // );

    return  CupertinoApp(
      home: CupertinoHome(),
    );
  }
}

class CupertinoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Home"),
          backgroundColor: Colors.grey,
          leading: Icon(CupertinoIcons.home, size: 18,),
        ),
        child: Column(
          children: [
            CupertinoButton(child: Text("Tap"), onPressed: (){}),
            CupertinoButton.filled(child: Text("Tap"), onPressed: (){}),
          ],
        ),
    );
  }

}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {},
              child: Text("Tap")),
          ElevatedButton(onPressed: () {}, child: Text("Tap")),
          ElevatedButton(onPressed: () {}, child: Text("Tap")),
        ],
      ),
    );
  }
}
