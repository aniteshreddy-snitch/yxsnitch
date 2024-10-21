import 'package:flutter/material.dart';
import 'package:yxsnitch/DeviceControl/device_control.dart';
import 'package:yxsnitch/LoginSignup/login_page.dart';
import 'package:yxsnitch/Organisation/organisationDetails/widgets/edit_organisation.dart';
import 'package:yxsnitch/Organisation/organisation_page.dart';
import 'package:yxsnitch/Organisation/userDetails/widgets/edit_user_details.dart';
import 'package:yxsnitch/changePassword/change_password.dart';
import 'package:yxsnitch/homepage/homepage.dart';
import 'package:yxsnitch/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white
          // Define the default brightness and colors.
          ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginView(),
        '/home': (context) => const HomePage(),
        '/device_details': (context) => const DeviceControl(),
        '/change_password': (context) => const ChangePassword(),
        '/organisation': (context) => const OrganisationPage(),
        '/organisation/edit-user': (context) => const EditUserPage(),
        '/organisation/edit-organisation': (context) =>
            const EditOrganisationPage()
      },
    );
  }
}
