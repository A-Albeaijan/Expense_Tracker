import 'package:flutter/material.dart';
import 'package:personal_experience/Widget/contiainerTop.dart';
import 'package:personal_experience/Widget/hoempage_button.dart';
import 'package:personal_experience/Widget/homepage_top.dart';

import '../Widget/list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    bool today = true;
    double height = MediaQuery.of(context).size.height;
    double width = (MediaQuery.of(context).size.width);
    return Stack(
      children: [
        Positioned(
          right: 0,
          left: 0,
          child: HomepageTop(height: height),
        ),
        Positioned(
          bottom: 9,
          right: 0,
          left: 0,
          child: ContiainerTop(
            height: height,
          ),
        ),
      ],
    );
  }
}
