import 'package:flutter/material.dart';

class HomepageTop extends StatefulWidget {
  const HomepageTop({super.key, required this.height});
  final double height;
  @override
  State<HomepageTop> createState() => _HomepageTopState(height);
}

class _HomepageTopState extends State<HomepageTop> {
  final double height;

  _HomepageTopState(this.height);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: height * 0.15,
      color: Color.fromARGB(255, 56, 182, 121),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Track Expense',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
