import 'package:flutter/material.dart';
import 'package:yxsnitch/components/utils/enums.dart';
import 'package:yxsnitch/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget fullScreenDevicesList(BuildContext context) {
  context.read<DashboardBloc>().add(DashboardDeviceFetchEvent());
  return BlocBuilder<DashboardBloc, DashboardState>(
    builder: (context, state) {
      // context.read<DashboardBloc>().add(DashboardDeviceFetchEvent());
      if (state.deviceApiStatus == APIStatus.loading) {
        return const SizedBox(
            height: 200.0,
            width: 200.0,
            child: Center(child: CircularProgressIndicator()));
      } else if (state.deviceApiStatus == APIStatus.success) {
        return DataTable(
          horizontalMargin: 0,
          columnSpacing: 5,
          clipBehavior: Clip.hardEdge,
          showCheckboxColumn: false,
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Status',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Group',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Category',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Room Light',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Actions',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: state.deviceList.map((device) {
            return DataRow(
              onSelectChanged: (value) {
                Navigator.pushNamed(
                  context,
                  '/device_details',
                  arguments: device.name,
                );
              },
              cells: <DataCell>[
                DataCell(Text(device.name)),
                DataCell(Text(device.status)),
                DataCell(Text(device.group.name)),
                DataCell(Text(device.category.name)),
                DataCell(Text(device.roomLight)),
                const DataCell(Text('Actions')),
              ],
            );
          }).toList(),
        );
      } else if (state.deviceApiStatus == APIStatus.error) {
        return Text('Error: ${state.message}');
      } else {
        return const Text('No data available');
      }
    },
  );
}

Widget mobileDeviceList(BuildContext context) {
  context.read<DashboardBloc>().add(DashboardDeviceFetchEvent());
  return BlocBuilder<DashboardBloc, DashboardState>(
    builder: (context, state) {
      if (state.deviceApiStatus == APIStatus.loading) {
        return const SizedBox(
          height: 200.0,
          width: 200.0,
          child: Center(child: CircularProgressIndicator()),
        );
      } else if (state.deviceApiStatus == APIStatus.success) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.deviceList.length,
          itemBuilder: (context, index) {
            final device = state.deviceList[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(device.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status: ${device.status}'),
                    Text('Group: ${device.group.name}'),
                    Text('Category: ${device.category.name}'),
                    Text('Room Light: ${device.roomLight}'),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // Show a bottom sheet or dialog with actions
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.add_box_outlined),
                            title: const Text('Add'),
                            onTap: () {
                              Navigator.pop(context);
                              // Navigator.pushNamed(
                              //   context,
                              //   '/device_details',
                              //   arguments: device.name,
                              // );
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.remove_circle_outline),
                            title: const Text('Decomission'),
                            onTap: () {
                              Navigator.pop(context);
                              // Navigator.pushNamed(
                              //   context,
                              //   '/device_details',
                              //   arguments: device.name,
                              // );
                            },
                          ),
                          // Add more action items as needed
                        ],
                      ),
                    );
                  },
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/device_details',
                    arguments: device.name,
                  );
                },
              ),
            );
          },
        );
      } else if (state.deviceApiStatus == APIStatus.error) {
        return Center(child: Text('Error: ${state.message}'));
      } else {
        return const Center(child: Text('No data available'));
      }
    },
  );
}
