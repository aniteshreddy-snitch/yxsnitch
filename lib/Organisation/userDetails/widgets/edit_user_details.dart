import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yxsnitch/Organisation/mappers/user_list_mapper.dart';
import 'package:yxsnitch/Organisation/userDetails/bloc/user_details_bloc.dart';

import 'package:yxsnitch/components/utils/enums.dart';
import 'package:yxsnitch/components/widgets/info_widget.dart';

class EditUserPage extends StatelessWidget {
  // final UserList? userDetail;

  const EditUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    if (null == arguments['userDetail']) {
      Navigator.pushReplacementNamed(context, '/organisation');
    }
    final UserList userDetail = arguments['userDetail'];
    return Scaffold(
        appBar: AppBar(title: const Text('Edit User')),
        body: BlocProvider(
          create: (context) => UserDetailsBloc(),
          child: BlocListener<UserDetailsBloc, UserDetailsState>(
            listener: (context, state) {
              if (state.postApiStatus == APIStatus.unauthorized) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                      SnackBar(content: Text(state.message.toString())));
                Navigator.pushNamed(context, '/login');
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return infoDialog(
                        context, "Login Expired", "Please login to continue");
                  },
                );
              } else if (state.postApiStatus == APIStatus.success) {
                Navigator.pop(context);

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return infoDialog(
                        context, "Info", "Details Successfully updated");
                  },
                );
              } else if (state.deleteApiStatus == APIStatus.success) {
                Navigator.pop(context);

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return infoDialog(
                        context, "Info", "Details Successfully updated");
                  },
                );
              }
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: EditUserForm(
                userDetail: userDetail,
              ),
            ),
          ),
        ));
  }
}

class EditUserForm extends StatefulWidget {
  final UserList? userDetail;

  const EditUserForm({super.key, this.userDetail});

  @override
  _EditUserFormState createState() => _EditUserFormState();
}

class _EditUserFormState extends State<EditUserForm> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneNumberController;
  late bool isOwner;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.userDetail?.email);
    passwordController =
        TextEditingController(text: widget.userDetail?.password);
    phoneNumberController =
        TextEditingController(text: widget.userDetail?.phoneNumber);
    isOwner = widget.userDetail?.isOwner ?? false;
  }

  InputDecoration formTextInputDecoration(String labelText) {
    return InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsBloc, UserDetailsState>(
        builder: (context, state) {
      if (state.postApiStatus == APIStatus.loading) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              decoration: formTextInputDecoration('Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: formTextInputDecoration('Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneNumberController,
              decoration: formTextInputDecoration('Phone Number'),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Is Owner'),
              value: isOwner,
              onChanged: (bool value) {
                setState(() {
                  isOwner = value;
                });
              },
            ),
            const SizedBox(height: 32),
            state.message != ''
                ? Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  )
                : Container(),
            ElevatedButton(
              style: _buttonStyle,
              onPressed: () {
                final updatedUser = UserList(
                  id: widget.userDetail!.id,
                  email: emailController.text,
                  password: passwordController.text,
                  phoneNumber: phoneNumberController.text,
                  isOwner: isOwner,
                );
                context
                    .read<UserDetailsBloc>()
                    .add(UserDetailsUpdateEvent(userList: updatedUser));
              },
              child: buttonText("Save Changes"),
            ),
            const SizedBox(height: 36),
            ElevatedButton(
              style: _buttonStyle.copyWith(
                  backgroundColor: WidgetStateProperty.all(
                      const Color.fromARGB(255, 255, 140, 140))),
              onPressed: () {
                context
                    .read<UserDetailsBloc>()
                    .add(UserDetailsDeleteEvent(userId: widget.userDetail!.id));
              },
              child: buttonText("Delete User"),
            ),
          ],
        );
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}

ButtonStyle _buttonStyle = ButtonStyle(
  backgroundColor:
      WidgetStateProperty.all(const Color.fromARGB(255, 162, 142, 216)),
  shape: WidgetStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
);

Text buttonText(String label) {
  return Text(label,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold));
}
