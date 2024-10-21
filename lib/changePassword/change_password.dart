import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yxsnitch/changePassword/bloc/change_password_bloc.dart';
import 'package:yxsnitch/changePassword/widgets/change_password_form.dart';
import 'package:yxsnitch/components/constants.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  ChangePasswordViewState createState() => ChangePasswordViewState();
}

class ChangePasswordViewState extends State<ChangePassword> {
  final formKey = GlobalKey<FormState>();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode oldPasswordFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  late ChangePasswordBloc changePasswordBloc = ChangePasswordBloc();

  @override
  void dispose() {
    emailFocusNode.dispose();
    oldPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (_) => changePasswordBloc,
        child: screenWidth > 600
            ? Row(
                children: [
                  mainSVGasset(size),
                  Flexible(flex: 1, child: Container()),
                  Expanded(
                    flex: 3,
                    child: buildChangePasswordForm(
                        size,
                        formKey,
                        context,
                        emailFocusNode,
                        oldPasswordFocusNode,
                        newPasswordFocusNode),
                  ),
                  screenWidth > 900
                      ? Flexible(flex: 2, child: Container())
                      : Container(),
                ],
              )
            : Center(
                child: buildChangePasswordForm(
                    size,
                    formKey,
                    context,
                    emailFocusNode,
                    oldPasswordFocusNode,
                    newPasswordFocusNode)),
      ),
    );
  }
}
