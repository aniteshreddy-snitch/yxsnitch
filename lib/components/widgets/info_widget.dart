import 'package:flutter/material.dart';

Widget infoDialog(BuildContext context, String title, String content) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: <Widget>[
      TextButton(
        child: const Text('Ok'),
        onPressed: () {
          Navigator.of(context).pop(); // Close the dialog
        },
      ),
    ],
  );
}
