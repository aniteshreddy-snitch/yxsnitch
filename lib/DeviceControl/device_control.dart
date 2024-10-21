import 'package:flutter/material.dart';
import 'package:yxsnitch/DeviceControl/components/activity_log.dart';
import 'package:yxsnitch/DeviceControl/components/box_widget.dart';
import 'package:yxsnitch/DeviceControl/components/command_input.dart';
import 'package:yxsnitch/DeviceControl/components/controls_settings.dart';
import 'package:yxsnitch/DeviceControl/components/device_details.dart';
import 'package:yxsnitch/components/constants.dart';
import 'package:yxsnitch/components/my_app_bar.dart';

class DeviceControl extends StatefulWidget {
  static const String route = '/device_details';

  const DeviceControl({super.key});

  @override
  State<DeviceControl> createState() => _DeviceControlState();
}

class _DeviceControlState extends State<DeviceControl> {
  @override
  Widget build(BuildContext context) {
    // String heading = ModalRoute.of(context)!.settings.arguments as String;
    //  screenWidth = MediaQuery.of(context).size.width;

    double screenWidth = MediaQuery.sizeOf(context).width;
    double padding = screenWidth * 0.05;
    int crossAxisCount = screenWidth > 1000 ? 2 : 1;
    double itemHeight = 450;
    double itemWidth = screenWidth / crossAxisCount;
    double childAspectRatio = itemWidth / itemHeight;

    String heading = "SNITCH";

    return Scaffold(
      appBar: myAppBar(yelloColor, screenWidth),
      backgroundColor: yelloColor,
      body: SingleChildScrollView(
          child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
            mainHeader(heading),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  const BoxWidget(heading: "Camera", contentWidget: SizedBox()),
                  const BoxWidget(
                      heading: "Controls", contentWidget: ControlSettings()),
                  BoxWidget(
                      heading: "Activity log", contentWidget: activityLog),
                  const BoxWidget(
                      heading: "Details", contentWidget: DeviceDetails())
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: const BoxWidget(
                    heading: "Details", contentWidget: CommandInputWidget()))
          ]))),
    );
  }
}
