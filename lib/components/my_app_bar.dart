import 'package:flutter/material.dart';

AppBar myAppBar(Color backgroundColor, var screenWidth) {
  return AppBar(
    automaticallyImplyLeading: screenWidth < 1150 ? true : false,
    toolbarHeight: 90,
    centerTitle: true,
    backgroundColor: backgroundColor,
    elevation: 2,
    title: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
                text: 'System Status\n',
                style: TextStyle(
                    fontSize: 22, letterSpacing: 2, wordSpacing: 6, height: 2)),
            TextSpan(
                text: 'No threats detected',
                style: TextStyle(fontSize: 16, height: 1.5))
          ],
        )),
  );
}
