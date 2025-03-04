import 'package:flutter/material.dart';

class GearsScreen extends StatefulWidget {
  const GearsScreen({super.key});

  @override
  State<GearsScreen> createState() => _GearsScreenState();
}

class _GearsScreenState extends State<GearsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Gears Screen")),
    );
  }
}
