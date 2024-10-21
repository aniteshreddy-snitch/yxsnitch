import 'package:flutter/material.dart';
import 'package:yxsnitch/LoginSignup/widgets/email_password_fields.dart';
import 'package:yxsnitch/LoginSignup/widgets/error_widget.dart';
import 'package:yxsnitch/LoginSignup/widgets/login_button.dart';
import 'package:yxsnitch/components/constants.dart';

/// Main Body
Widget buildFormField(Size size, final formKey, BuildContext context,
    FocusNode emailFocusNode, FocusNode passwordFocusNode
    // SimpleUIController simpleUIController,
    ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(
          'Login',
          style: kLoginTitleStyle(size),
        ),
      ),
      const SizedBox(
        height: 25,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(
          'Welcome Back to YXSnitch',
          style: kLoginSubtitleStyle(size),
        ),
      ),
      const SizedBox(
        height: 25,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              emailField(context, emailFocusNode),
              const SizedBox(
                height: 20,
              ),
              passwordField(context, passwordFocusNode),
              const SizedBox(
                height: 10,
              ),
              errormessage(),
              const SizedBox(
                height: 10,
              ),
              Text(
                'By logging in you agree with our Terms of Services and Privacy Policy',
                style: kLoginTermsAndPrivacyStyle(size),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25,
              ),
              loginButton(formKey),
            ],
          ),
        ),
      ),
    ],
  );
}
