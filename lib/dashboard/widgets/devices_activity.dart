import 'package:flutter/material.dart';
import 'package:yxsnitch/components/utils/enums.dart';
import 'package:yxsnitch/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

Widget dataTableActivityFullScreen(BuildContext context) {
  context.read<DashboardBloc>().add(DashboardActivityFetchEvent());
  return BlocBuilder<DashboardBloc, DashboardState>(
    builder: (context, state) {
      if (state.activityApiStatus == APIStatus.success) {
        return DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Activity',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Device',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                '',
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
                'Location',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: state.activityList.map((activity) {
            return DataRow(
              color:
                  WidgetStateProperty.all(getColorForStatus(activity.activity)),
              cells: <DataCell>[
                DataCell(Text(DateFormat('M/d/yyyy, h:mm:ss a')
                    .format(activity.createdDate))),
                DataCell(Text(activity.deviceName)),
                DataCell(getIconForStatus(activity.activity)),
                DataCell(Text(activity.activity)),
                DataCell(Text(activity.location)),
              ],
            );
          }).toList(),
        );
      } else {
        return const SizedBox(
            height: 200.0,
            width: 200.0,
            child: Center(child: CircularProgressIndicator()));
      }
    },
  );
}

Widget dataTableActivityMobile(BuildContext context) {
  context.read<DashboardBloc>().add(DashboardActivityFetchEvent());
  return BlocBuilder<DashboardBloc, DashboardState>(
    builder: (context, state) {
      if (state.activityApiStatus == APIStatus.success) {
        return ListView.builder(
          itemCount: state.activityList.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            final activity = state.activityList[index];
            return Card(
              color: getColorForStatus(activity.activity),
              child: ListTile(
                title: Text(
                  DateFormat('M/d/yyyy, h:mm:ss a')
                      .format(activity.createdDate),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text('Device: ${activity.deviceName}'),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        getIconForStatus(activity.activity),
                        const SizedBox(width: 8),
                        Text('Status: ${activity.activity}'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Location: ${activity.location}'),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        return const SizedBox(
            height: 200.0,
            width: 200.0,
            child: Center(child: CircularProgressIndicator()));
      }
    },
  );
}

Color getColorForStatus(String status) {
  switch (status) {
    case 'On':
      return Colors.white;
    case 'Connected':
      return Colors.blue[100]!;
    case 'Off':
    case 'Not Connected':
    case 'Lost Connection':
      return Colors.orange[100]!;
    case 'Device Restarted':
      return Colors.yellow[100]!;
    case 'Threat Cleared':
      return Colors.green[100]!;
    case 'Threat Detected':
      return Colors.red[100]!;
    default:
      return Colors.white;
  }
}

Widget getIconForStatus(String status) {
  IconData iconData;
  Color iconColor;

  switch (status) {
    case 'On':
    case 'Connected':
      iconData = Icons.check_circle;
      iconColor = Colors.green;
      break;
    case 'Off':
    case 'Not Connected':
    case 'Lost Connection':
      iconData = Icons.error;
      iconColor = Colors.red;
      break;
    case 'Device Restarted':
      iconData = Icons.refresh;
      iconColor = Colors.orange;
      break;
    case 'Threat Cleared':
      iconData = Icons.security;
      iconColor = Colors.green;
      break;
    case 'Threat Detected':
      iconData = Icons.warning;
      iconColor = Colors.red;
      break;
    default:
      iconData = Icons.info;
      iconColor = Colors.blue;
  }

  return Icon(iconData, color: iconColor);
}
