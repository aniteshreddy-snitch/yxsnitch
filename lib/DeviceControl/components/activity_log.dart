import 'package:flutter/material.dart';

Widget activityLog = Column(
  children: [
    _buildActivityItem(
      date: '7/6/2024, 7:19:02 PM',
      device: 'SNITCH-17A4',
      icon: Icons.info_outlined,
      iconColor: const Color.fromARGB(255, 139, 128, 6),
      location: 'Room 304',
      backgroundColor: const Color.fromARGB(255, 248, 240, 153),
    ),
    _buildActivityItem(
      date: '7/6/2024, 7:19:00 PM',
      device: 'SNITCH-17A4',
      icon: Icons.info_outlined,
      iconColor: const Color.fromARGB(255, 139, 128, 6),
      location: 'Room 304',
      backgroundColor: const Color.fromARGB(255, 248, 240, 153),
    ),
    _buildActivityItem(
      date: '7/6/2024, 7:06:01 PM',
      device: 'SNITCH-17A4',
      icon: Icons.lightbulb_circle,
      location: 'Room 304',
    ),
    _buildActivityItem(
      date: '7/6/2024, 7:05:25 PM',
      device: 'SNITCH-17A4',
      icon: Icons.info_rounded,
      location: 'Room 304',
      backgroundColor: const Color.fromARGB(255, 198, 246, 190),
    ),
    _buildActivityItem(
      date: '7/6/2024, 7:05:24 PM',
      device: 'SNITCH-17A4',
      icon: Icons.info_rounded,
      location: 'Room 304',
      backgroundColor: const Color.fromARGB(255, 235, 183, 183),
    ),
  ],
);

Widget _buildActivityItem({
  required String date,
  required String device,
  required IconData icon,
  required String location,
  Color backgroundColor = Colors.transparent,
  Color iconColor = Colors.black,
}) {
  return Container(
    color: backgroundColor,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(date, style: const TextStyle(fontSize: 14)),
        ),
        Expanded(
          flex: 2,
          child: Text(device, style: const TextStyle(fontSize: 14)),
        ),
        Expanded(
          flex: 1,
          child: Icon(icon, color: iconColor, size: 20),
        ),
        Expanded(
          flex: 2,
          child: Text(location, style: const TextStyle(fontSize: 14)),
        ),
      ],
    ),
  );
}
