import 'package:flutter/material.dart';

import 'hoempage_button.dart';
import 'list.dart';

class ContiainerTop extends StatefulWidget {
  const ContiainerTop({super.key, required this.height});
  final double height;
  @override
  State<ContiainerTop> createState() => _ContiainerTopState(height);
}

class _ContiainerTopState extends State<ContiainerTop> {
  final double height;

  _ContiainerTopState(this.height);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: height * 0.65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),

          //date /total spent
          exList(
            height: height,
          ),
        ],
      ),
    );
  }
}
