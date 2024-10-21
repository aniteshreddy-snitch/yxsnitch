import 'package:flutter/material.dart';
import 'package:yxsnitch/LoginSignup/bloc/login_bloc.dart';
import 'package:yxsnitch/LoginSignup/widgets/form_field.dart';
import 'package:yxsnitch/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  late LoginBloc loginBloc;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    var size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: BlocProvider(
            create: (_) => loginBloc,
            
            child: screenWidth > 600
                ? Row(
                    children: [
                      mainSVGasset(size),
                      Flexible(flex: 1, child: Container()),
                      Expanded(
                        flex: 3,
                        child: buildFormField(size, formKey, context,
                            emailFocusNode, passwordFocusNode),
                      ),
                      screenWidth > 900
                          ? Flexible(flex: 2, child: Container())
                          : Container(),
                    ],
                  )
                : Center(
                    child: buildFormField(size, formKey, context,
                        emailFocusNode, passwordFocusNode))));
  }
}


