// Login Button
import 'package:flutter/material.dart';
import 'package:yxsnitch/LoginSignup/bloc/login_bloc.dart';
import 'package:yxsnitch/components/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yxsnitch/components/widgets/info_widget.dart';

Widget loginButton(final formKey) {
  return BlocListener<LoginBloc, LoginState>(
    listener: (context, state) {
      if (state.apiStatus == APIStatus.error) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.message.toString())));
      }
      if (state.apiStatus == APIStatus.loading) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.message.toString())));
      }
      if (state.apiStatus == APIStatus.success) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', (Route<dynamic> route) => false);
      }
      if (state.apiStatus == APIStatus.changePassword) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.message.toString())));
        Navigator.pushNamed(context, '/change_password');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return infoDialog(context, "Change Password",
                "Please change the password to login");
          },
        );
      }
    },
    child: BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                  const Color.fromARGB(255, 162, 142, 216)),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(LoginFormSubmitted());
                // ... Navigate To your Home Page
              }
            },
            child: state.apiStatus == APIStatus.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
          ),
        );
      },
    ),
  );
}
