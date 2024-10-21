import 'package:flutter/material.dart';
import 'package:yxsnitch/Organisation/organisationDetails/bloc/organisation_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yxsnitch/Organisation/mappers/organisation_detail_mapper.dart';
import 'package:yxsnitch/Organisation/organisationDetails/widgets/edit_organisation.dart';
import 'package:yxsnitch/Organisation/organisationDetails/widgets/organisation_detail_row.dart';
import 'package:yxsnitch/Organisation/userDetails/bloc/user_details_bloc.dart';
import 'package:yxsnitch/Organisation/userDetails/widgets/add_user_details.dart';
import 'package:yxsnitch/components/utils/enums.dart';
import 'package:yxsnitch/components/widgets/info_widget.dart';

class OrganisationDetailsCard extends StatelessWidget {
  final bool isOwner;
  const OrganisationDetailsCard({super.key, required this.isOwner});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    // context.read<OrganisationBloc>().add(OrganisationFetchEvent());
    return BlocListener<OrganisationBloc, OrganisationState>(
        listener: (context, state) {
      if (state.apiStatus == APIStatus.unauthorized) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.message.toString())));
        Navigator.pushNamed(context, '/login');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return infoDialog(
                context, "Login Expired", "Please login to continue");
          },
        );
      }
    }, child: BlocBuilder<OrganisationBloc, OrganisationState>(
      builder: (context, state) {
        if (state.apiStatus == APIStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.apiStatus == APIStatus.error) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state.apiStatus == APIStatus.success) {
          return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Card(
                color: Colors.white,
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16),
                        buildDetailRow('Name', state.organisationDetail?.name,
                            screenWidth),
                        buildDetailRow(
                            'Address',
                            state.organisationDetail?.streetAddress,
                            screenWidth),
                        buildDetailRow(
                            'Pincode',
                            state.organisationDetail?.pincode.toString(),
                            screenWidth),
                        buildDetailRow('City', state.organisationDetail?.city,
                            screenWidth),
                        buildDetailRow('State', state.organisationDetail?.state,
                            screenWidth),
                        if (isOwner) ...[
                          Row(
                            children: [
                              const SizedBox(height: 16),
                              _editOrganisationDetails(screenWidth, context,
                                  state.organisationDetail),
                              Container(
                                color: Colors.white,
                                width: 25,
                              ),
                              _addNewUser(screenWidth, context)
                            ],
                          )
                        ],
                      ]),
                ),
              ));
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    ));
  }
}

Widget _editOrganisationDetails(double screenWidth, BuildContext context,
    OrganisationDetail? organisationDetail) {
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
        Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditOrganisationPage(
                      organisationDetail: organisationDetail),
                ))
            .then((value) =>
                context.read<OrganisationBloc>().add(OrganisationFetchEvent()));
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            scrollable: true,
            content: ConstrainedBox(
              constraints: const BoxConstraints(
                  maxWidth: 400,
                  minWidth: 400,
                  maxHeight: 500), // Set your desired width
              child: EditOrganisationPage(
                organisationDetail: organisationDetail,
              ),
            ),
          ),
        ).then((value) =>
            context.read<OrganisationBloc>().add(OrganisationFetchEvent()));
      }
    },
    child: const Text(
      'Edit details',
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
  );
}

Widget _addNewUser(double screenWidth, BuildContext context) {
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
        Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddUserPage(),
                ))
            .then((value) =>
                context.read<UserDetailsBloc>().add(GetUserDetailsEvent()));
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            scrollable: true,
            content: ConstrainedBox(
              constraints: const BoxConstraints(
                  maxWidth: 400,
                  minWidth: 400,
                  maxHeight: 500), // Set your desired width
              child: const AddUserPage(),
            ),
          ),
        ).then((value) =>
            context.read<UserDetailsBloc>().add(GetUserDetailsEvent()));
      }
    },
    child: const Text(
      'Add New User',
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
  );
}
