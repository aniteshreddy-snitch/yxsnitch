import 'package:flutter/material.dart';
import 'package:yxsnitch/Organisation/organisationDetails/bloc/organisation_bloc.dart';
import 'package:yxsnitch/Organisation/mappers/organisation_detail_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yxsnitch/components/utils/enums.dart';
import 'package:yxsnitch/components/widgets/info_widget.dart';

class EditOrganisationPage extends StatelessWidget {
  final OrganisationDetail? organisationDetail;

  const EditOrganisationPage({super.key, this.organisationDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Organisation')),
      body: BlocProvider(
          create: (_) => OrganisationBloc(),
          child: BlocListener<OrganisationBloc, OrganisationState>(
            listener: (context, state) {
              if (state.apiStatus == APIStatus.unauthorized) {
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
              } else if (state.apiStatus == APIStatus.success) {
                Navigator.pop(context);

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return infoDialog(
                        context, "Info", "Details Successfully updated");
                  },
                );
                // context.read<OrganisationBloc>().add(OrganisationFetchEvent());
              }
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: EditOrganisationForm(
                organisationDetail: organisationDetail,
              ),
            ),
          )),
    );
  }
}

class EditOrganisationForm extends StatefulWidget {
  final OrganisationDetail? organisationDetail;

  const EditOrganisationForm({super.key, required this.organisationDetail});

  @override
  // ignore: library_private_types_in_public_api
  _EditOrganisationFormState createState() => _EditOrganisationFormState();
}

class _EditOrganisationFormState extends State<EditOrganisationForm> {
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController pincodeController;
  late TextEditingController cityController;
  late TextEditingController stateController;

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.organisationDetail?.name);
    addressController =
        TextEditingController(text: widget.organisationDetail?.streetAddress);
    pincodeController = TextEditingController(
        text: widget.organisationDetail?.pincode.toString());
    cityController =
        TextEditingController(text: widget.organisationDetail?.city);
    stateController =
        TextEditingController(text: widget.organisationDetail?.state);
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
    return BlocBuilder<OrganisationBloc, OrganisationState>(
        builder: (context, state) {
      if (state.apiStatus == APIStatus.loading) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: formTextInputDecoration('Name'),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: addressController,
              decoration: formTextInputDecoration('Address'),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: pincodeController,
              decoration: formTextInputDecoration('Pincode'),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: cityController,
              decoration: formTextInputDecoration('City'),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: stateController,
              decoration: formTextInputDecoration('State'),
            ),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(height: 32),
            state.message != ''
                ? Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  )
                : Container(),
            ElevatedButton(
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
                final updatedOrganisation = OrganisationDetail(
                  id: widget.organisationDetail!.id,
                  name: nameController.text,
                  streetAddress: addressController.text,
                  pincode: int.parse(pincodeController.text),
                  city: cityController.text,
                  state: stateController.text,
                );
                context.read<OrganisationBloc>().add(
                    OrganisationUpdateDetailsEvent(
                        organisationDetail: updatedOrganisation));
              },
              child: const Text('Save Changes',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    stateController.dispose();
    super.dispose();
  }
}
