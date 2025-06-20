import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(DailyJournalApp());
}

class DailyJournalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Journal',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomeScreen(),
    );
  }
}
