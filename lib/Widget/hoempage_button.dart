import 'package:flutter/material.dart';

class HomepageButton extends StatefulWidget {
  const HomepageButton({super.key, required this.height});
  final double height;
  @override
  State<HomepageButton> createState() => _HomepageButtonState(height);
}

class _HomepageButtonState extends State<HomepageButton> {
  final double height;
  bool today = true;
  _HomepageButtonState(this.height);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: today == true
                  ? Color.fromARGB(255, 23, 69, 92)
                  : Colors.grey[300],
            ),
            child: Center(
              child: InkWell(
                onTap: () => setState(() {
                  today = true;
                }),
                child: Text(
                  'Week',
                  style: TextStyle(
                      color: today == true
                          ? Colors.white
                          : Color.fromARGB(255, 23, 69, 92)),
                ),
              ),
            ),
          ),
          Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: today == false
                  ? Color.fromARGB(255, 23, 69, 92)
                  : Colors.grey[300],
            ),
            child: Center(
              child: InkWell(
                onTap: () => setState(() {
                  today = false;
                }),
                child: Text(
                  'Month',
                  style: TextStyle(
                    color: today == false
                        ? Colors.white
                        : Color.fromARGB(255, 23, 69, 92),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
