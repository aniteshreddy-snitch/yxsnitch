import 'package:flutter/material.dart';
import 'package:yxsnitch/LoginSignup/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget errormessage() {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: state.message != ''
              ? Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                )
              : Container());
    },
  );
}
