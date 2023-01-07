import 'package:flutter/material.dart';
import 'package:personal_experience/Screen/diagram.dart';
import 'package:personal_experience/Screen/homepage.dart';
import 'package:sqflite/sqflite.dart';
import '../sql/db.dart';
import 'add.dart';

class ButtomBar extends StatefulWidget {
  const ButtomBar({super.key});
  @override
  State<ButtomBar> createState() => _ButtomBarState();
}

class _ButtomBarState extends State<ButtomBar> {
  int pageIndex = 0;

  final pages = [
    const HomePage(),
    const Add(),
    const Diagram(),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          color: const Color.fromARGB(255, 56, 182, 121),
        ),
      ),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Widget buildMyNavBar(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.all(10),
      height: height * 0.09,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 23, 69, 92),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(
                () {
                  pageIndex = 0;
                },
              );
            },
            icon: Icon(
              pageIndex == 0
                  ? Icons.account_balance_wallet_rounded
                  : Icons.account_balance_wallet_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(
                () {
                  pageIndex = 1;
                },
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(
                () {
                  pageIndex = 2;
                },
              );
            },
            icon: Icon(
              pageIndex == 2 ? Icons.draw : Icons.draw_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
