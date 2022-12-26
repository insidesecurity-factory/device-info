import 'dart:io';
import 'package:flutter/material.dart';
import 'controller/cpu/cpu_controller.dart';


class MyApp extends StatelessWidget {

  const MyApp({ super.key });

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Device info',
      theme: ThemeData(
        brightness: Brightness.light
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        body: CpuController()
      )
    );
  }
}

void main() {
  runApp(const MyApp());
}