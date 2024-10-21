import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yxsnitch/changePassword/bloc/change_password_bloc.dart';
import 'package:yxsnitch/components/utils/enums.dart';
import 'package:yxsnitch/components/widgets/info_widget.dart';

Widget changePasswordButton(GlobalKey<FormState> formKey) {
  return BlocListener<ChangePasswordBloc, ChangePasswordState>(
    listener: (context, state) {
      if (state.apiStatus == APIStatus.success) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/login', (Route<dynamic> route) => false);
        // Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return infoDialog(context, "Password Reset Succesful",
                "Please Login with new Password and Email ID");
          },
        );
      }
    },
    child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) =>
          current.newPassword != previous.newPassword ||
          current.oldPassword != current.oldPassword,
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
            onPressed: state.apiStatus == APIStatus.loading
                ? null
                : () {
                    if (formKey.currentState!.validate()) {
                      context
                          .read<ChangePasswordBloc>()
                          .add(ChangePasswordSubmittedEvent());
                    }
                  },
            child: state.apiStatus == APIStatus.loading
                ? const CircularProgressIndicator()
                : const Text(
                    'Change Password',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
          ),
        );
      },
    ),
  );
}
