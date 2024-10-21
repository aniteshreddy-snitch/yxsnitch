import 'package:flutter/material.dart';
import 'package:yxsnitch/changePassword/widgets/change_password_button.dart';
import 'package:yxsnitch/changePassword/widgets/email_password_change_fields.dart';
import 'package:yxsnitch/changePassword/widgets/error_widget.dart';
import 'package:yxsnitch/components/constants.dart';

Widget buildChangePasswordForm(
    Size size,
    final formKey,
    BuildContext context,
    FocusNode emailFocusNode,
    FocusNode oldPasswordFocusNode,
    FocusNode newPasswordFocusNode) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(
          'Change Password',
          style: kLoginTitleStyle(size),
        ),
      ),
      const SizedBox(
        height: 25,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(
          'Please change password to continue',
          style: kLoginSubtitleStyle(size),
        ),
      ),
      const SizedBox(height: 25),
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              emailField(emailFocusNode),
              const SizedBox(height: 20),
              oldPasswordField(context, oldPasswordFocusNode),
              const SizedBox(height: 20),
              newPasswordField(context, newPasswordFocusNode),
              const SizedBox(height: 10),
              errormessage(),
              const SizedBox(height: 15),
              changePasswordButton(formKey)
            ],
          ),
        ),
      ),
    ],
  );
}
