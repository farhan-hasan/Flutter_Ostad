import 'package:flutter/material.dart';

/// Orientation builder
/// Layout Builder
/// MediaQuery
/// const uses on widgets
/// package : flutter_screenutil, responsive_builder

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).orientation);
    print(MediaQuery.of(context).size);
    print(MediaQuery.of(context).size.aspectRatio);
    print(MediaQuery.of(context).size.longestSide);

    print(MediaQuery.sizeOf(context));
    print(MediaQuery.orientationOf(context));
    print(MediaQuery.devicePixelRatioOf(context));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      // body: const Column(
      //   children: [
      //     Scrollbar(
      //       thickness : 3,
      //       interactive : true,
      //       child: SingleChildScrollView(
      //         scrollDirection: Axis.horizontal,
      //         child: Row(
      //           children: [
      //             Text("aaaaaaaaaaaaaaaaaaaaaaaaaaaa"),
      //             Text("bbbbbbbbbbbbbbbb"),
      //             Text("cccccccccccccccc")
      //           ],
      //         ),
      //       ),
      //     ),
      //     Wrap(
      //       alignment: WrapAlignment.center,
      //       crossAxisAlignment: WrapCrossAlignment.center,
      //       spacing: 10,
      //       children: [
      //         Text("aaaaaaaaaaaaaaaaaaaaaaaaaaaa"),
      //         Text("bbbbbbbbbbbbbbbb"),
      //         Text("cccccccccccccccccccccccccccccccccccccccccccc")
      //       ],
      //     ),
      //     // OrientationBuilder(
      //     //     builder: (context, ori) {
      //     //       if(ori==Orientation.portrait) {
      //     //         return Text("Portrait");
      //     //       }
      //     //       else {
      //     //         return Text("Landscape");
      //     //       }
      //     //     },
      //     // )
      //   ],
      // ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if(constraints.maxWidth<300) {
            return Text("Tiny Device");
          }
          else {
            return Text("Not Tiny Device");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          count++;
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
