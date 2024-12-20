import 'package:flutter/material.dart';

class RecentHistory extends StatefulWidget {
  const RecentHistory({super.key});

  @override
  State<RecentHistory> createState() => _RecentHistoryState();
}

class _RecentHistoryState extends State<RecentHistory> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Recent History")),
    );
  }
}
