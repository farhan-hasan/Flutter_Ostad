import 'package:flutter/cupertino.dart';

/// 1. Input two numbers
/// 2. Inputs should be numbers
/// 3. Add Button, Sub Button
/// 4. Clear Button
/// 5. Result should be shown in text
/// 6. Text should be visible when there is result

import 'package:flutter/material.dart';
import 'home_screen.dart';
void main () {
  runApp(SumApp());
}

class SumApp extends StatelessWidget {
  const SumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}