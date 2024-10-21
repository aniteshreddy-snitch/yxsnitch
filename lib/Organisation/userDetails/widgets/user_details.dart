import 'package:flutter/material.dart';
import 'package:yxsnitch/Organisation/mappers/user_list_mapper.dart';
import 'package:yxsnitch/Organisation/userDetails/bloc/user_details_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yxsnitch/Organisation/userDetails/widgets/edit_user_details.dart';
import 'package:yxsnitch/components/utils/enums.dart';
import 'package:yxsnitch/components/utils/network/auth_service.dart';

class UserDetailsColumn extends StatefulWidget {
  final bool isOwner;
  const UserDetailsColumn({super.key, required this.isOwner});

  @override
  // ignore: no_logic_in_create_state
  State<UserDetailsColumn> createState() => _UserDetailsColumnState();
}

class _UserDetailsColumnState extends State<UserDetailsColumn> {
  final AuthService _authService = AuthService();

  late bool isOwner = false;
  late String currentEmail = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final ownerStatus = await _authService.getOwner();
    final selfEmail = await _authService.getEmail();
    setState(() {
      isOwner = ownerStatus == true;
      currentEmail = selfEmail!;
    });
    // tabController = TabController(length: isOwner ? 3 : 2, vsync: this);
  }
  // final UserDetailsBloc userDetailsBloc = UserDetailsBloc();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return screenWidth < 600
        ? userSmallScreenWidget(isOwner, context, currentEmail)
        : userFullScreenWidget(context, isOwner, currentEmail);
  }
}

Widget userSmallScreenWidget(
    bool isOwner, BuildContext context, String currentEmail) {
  // context.read<UserDetailsBloc>().add(GetUserDetailsEvent());
  double screenWidth = MediaQuery.sizeOf(context).width;
  return BlocBuilder<UserDetailsBloc, UserDetailsState>(
    builder: (context, state) {
      return ListView.builder(
          shrinkWrap: true,
          primary: false,
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: state.userList.length,
          itemBuilder: (context, index) {
            return Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Name', state.userList[index].email),
                      _buildDetailRow('Email', state.userList[index].email),
                      _buildDetailRow(
                          'Phone', state.userList[index].phoneNumber),
                      _buildDetailRow('Owner',
                          state.userList[index].isOwner ? 'Yes' : 'No'),
                      if (state.myDetails!.isOwner ||
                          state.myDetails?.email ==
                              state.userList[index].email) ...[
                        const SizedBox(height: 16),
                        editUserDetails(screenWidth, context,
                            userList: state.userList[index])
                      ],
                    ],
                  ),
                ));
          });
    },
  );
}

Widget _buildDetailRow(String label, dynamic value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value?.toString() ?? 'N/A'),
      ],
    ),
  );
}

Widget userFullScreenWidget(
    BuildContext context, bool isOwner, String currentEmail) {
  // context.read<UserDetailsBloc>().add(GetUserDetailsEvent());
  double screenWidth = MediaQuery.sizeOf(context).width;
  return BlocBuilder<UserDetailsBloc, UserDetailsState>(
    builder: (context, state) {
      if (state.getApiStatus == APIStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state.getApiStatus == APIStatus.error) {
        return Text('Error: ${state.message}');
      } else if (state.getApiStatus == APIStatus.success) {
        return SingleChildScrollView(
          primary: false,
          child: DataTable(
            horizontalMargin: 16,
            columnSpacing: 5,
            showCheckboxColumn: false,
            columns: const [
              DataColumn(
                label:
                    Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              DataColumn(
                  label: Text('Email',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Phone',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Status',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Actions',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: state.userList.map((user) {
              return DataRow(
                cells: [
                  DataCell(
                    SizedBox(
                      width: 180, // Adjust this value as needed
                      child: Text(
                        user.email,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 180, // Adjust this value as needed
                      child: Text(
                        user.email,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  DataCell(Text(user.phoneNumber.toString())),
                  DataCell(Text(user.isOwner ? 'Admin' : 'User')),
                  DataCell(state.myDetails!.isOwner ||
                          state.myDetails?.email == user.email
                      ? editUserDetails(screenWidth, context, userList: user)
                      : const Text("NA")),
                ],
              );
            }).toList(),
          ),
        );
      } else {
        return Text('No data available : ${state.message}');
      }
    },
  );
}

Widget editUserDetails(double screenWidth, BuildContext context,
    {UserList? userList}) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor:
          WidgetStateProperty.all(const Color.fromARGB(255, 162, 142, 216)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
    onPressed: () {
      if (screenWidth < 550) {
        Navigator.pushNamed(context, '/organisation/edit-user',
                arguments: {'userDetail': userList})
            .then((value) =>
                context.read<UserDetailsBloc>().add(GetUserDetailsEvent()));
        // Navigator.push(
        //         context,
        //         MaterialPageRoute(
        // builder: (context) => EditUserPage(userDetail: userList),
        //         ))
        //     .then((value) =>
        //         context.read<UserDetailsBloc>().add(GetUserDetailsEvent()));
      } else {
        showDialog(
          context: context,
          routeSettings: RouteSettings(arguments: {'userDetail': userList}),
          builder: (context) => AlertDialog(
            scrollable: true,
            content: ConstrainedBox(
              constraints: const BoxConstraints(
                  maxWidth: 400,
                  minWidth: 400,
                  maxHeight: 500), // Set your desired width
              child: const EditUserPage(
                 
                  ),
            ),
          ),
        ).then((value) =>
            context.read<UserDetailsBloc>().add(GetUserDetailsEvent()));
      }
    },
    child: const Text(
      'Edit details',
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
  );
}
