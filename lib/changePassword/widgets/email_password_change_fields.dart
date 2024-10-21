import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yxsnitch/changePassword/bloc/change_password_bloc.dart';

Widget emailField(FocusNode emailFocusNode) {
  return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
    buildWhen: (previous, current) => current.email != previous.email,
    builder: (context, state) {
      return TextFormField(
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.email),
          hintText: 'Email ID',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        // focusNode: emailFocusNode,
        onChanged: (value) {
          context
              .read<ChangePasswordBloc>()
              .add(EmailChangedEvent(email: value));
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          return null;
        },
      );
    },
  );
}

Widget oldPasswordField(BuildContext context, FocusNode oldPasswordFocusNode) {
  return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
    buildWhen: (previous, current) =>
        current.oldPassword != previous.oldPassword,
    builder: (context, state) {
      return TextFormField(
        style: const TextStyle(color: Colors.black),
        obscureText: true,
        focusNode: oldPasswordFocusNode,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock),
          hintText: 'Old Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        onChanged: (value) {
          context
              .read<ChangePasswordBloc>()
              .add(OldPasswordChangedEvent(oldPassword: value));
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your old password';
          }
          return null;
        },
      );
    },
  );
}

Widget newPasswordField(BuildContext context, FocusNode newPasswordFocusNode) {
  return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
    buildWhen: (previous, current) =>
        current.newPassword != previous.newPassword,
    builder: (context, state) {
      return TextFormField(
        style: const TextStyle(color: Colors.black),
        obscureText: true,
        focusNode: newPasswordFocusNode,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock_open),
          hintText: 'New Password',
          errorText: null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        onChanged: (value) {
          context
              .read<ChangePasswordBloc>()
              .add(NewPasswordChangedEvent(newPassword: value));
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a new password';
          } else if (value.length < 6) {
            return 'Password must be at least 6 characters long';
          }
          return null;
        },
      );
    },
  );
}
