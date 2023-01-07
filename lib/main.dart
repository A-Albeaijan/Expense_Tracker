import 'package:flutter/material.dart';
import 'package:personal_experience/Screen/add.dart';
import 'package:personal_experience/Screen/homepage.dart';

import 'Screen/bottmbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: ButtomBar(),
      routes: {
        'homepage': (context) => const HomePage(),
        'add': (context) => const Add(),
      },
    );
  }
}
