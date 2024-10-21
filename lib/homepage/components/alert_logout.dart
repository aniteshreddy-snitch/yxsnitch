import 'package:flutter/material.dart';
import 'package:yxsnitch/components/utils/network/auth_service.dart';

Widget logoutDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Confirm Logout'),
    content: const Text('Are you sure you want to logout?'),
    actions: <Widget>[
      TextButton(
        child: const Text('Cancel'),
        onPressed: () {
          Navigator.of(context).pop(); // Close the dialog
        },
      ),
      TextButton(
        child: const Text('Logout'),
        onPressed: () async {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );

          await AuthService().deleteToken();
          if (!context.mounted) return;
          Navigator.of(context).pop();
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/login',
            (Route<dynamic> route) => false,
          );
        },
      ),
    ],
  );
}
