import 'package:flutter/cupertino.dart';

/// 1. Round tap button that adds a new glass of water
/// 2. List of consumed glasses
/// 3. number of glasses and time of consumption
/// 4. Show list

import 'package:flutter/material.dart';
import 'home_screen.dart';
void main () {
  runApp(WaterTrackerApp());
}

class WaterTrackerApp extends StatelessWidget {
  const WaterTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
