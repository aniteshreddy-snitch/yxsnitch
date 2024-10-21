import 'package:flutter/material.dart';
import 'package:yxsnitch/LoginSignup/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget emailField(BuildContext context, FocusNode emailFocusNode) {
  return BlocBuilder<LoginBloc, LoginState>(
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
        // The validator receives the text that the user has entered.
        onChanged: (value) {
          context.read<LoginBloc>().add(EmailChangedEvent(email: value));
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter username';
          } else if (value.length < 4) {
            return 'at least enter 4 characters';
          }
          return null;
        },
      );
    },
  );
}

Widget passwordField(BuildContext context, FocusNode passwordFocusNode) {
  return BlocBuilder<LoginBloc, LoginState>(
    buildWhen: (previous, current) =>
        current.password != previous.password ||
        current.message != previous.message,
    builder: (context, state) {
      return TextFormField(
        style: const TextStyle(color: Colors.black),
        obscureText: true,
        focusNode: passwordFocusNode,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock_open),
          hintText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        onChanged: (value) {
          context.read<LoginBloc>().add(PasswordChangedEvent(password: value));
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      );
    },
  );
}
