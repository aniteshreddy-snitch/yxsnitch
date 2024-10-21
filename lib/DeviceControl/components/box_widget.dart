import 'package:flutter/material.dart';

class BoxWidget extends StatelessWidget {
  final Widget contentWidget;
  final String heading;
  const BoxWidget(
      {super.key, required this.contentWidget, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 220, 219, 219),
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: Center(
              child: Text(
                heading,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 3,
            color: Colors.black,
          ),
          contentWidget,
        ],
      ),
    );
  }
}
