import 'package:flutter/material.dart';


Widget buildDetailRow(String label, String? value, double screenWidth) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(value ?? 'N/A'),
          ),
        ),
        screenWidth > 1100
            ? Expanded(flex: 2, child: Container())
            : screenWidth > 700
                ? Expanded(flex: 1, child: Container())
                : Container()
      ],
    ),
  );
}
