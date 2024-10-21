import 'package:flutter/material.dart';
import 'package:yxsnitch/components/constants.dart';
// import 'package:yxsnitch/components/my_app_bar.dart';
import 'package:yxsnitch/dashboard/widgets/devices_activity.dart';
import 'package:yxsnitch/dashboard/widgets/devices_table.dart';

Widget tableViewScreen(TabController tabController, BuildContext context) {
  return LayoutBuilder(builder: (context, constraints) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mainHeader("Dashboard"),
          TabBar(
            isScrollable: true,
            controller: tabController,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(text: 'Devices'),
              Tab(text: 'Activity'),
            ],
            labelColor: Colors.black,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: constraints.maxWidth < 600
                  ? [
                      SingleChildScrollView(child: mobileDeviceList(context)),
                      SingleChildScrollView(
                          child: dataTableActivityMobile(context))
                    ]
                  : [
                      SingleChildScrollView(
                          child: fullScreenDevicesList(context)),
                      SingleChildScrollView(
                          child: dataTableActivityFullScreen(context))
                    ],
            ),
          ),
        ],
      ),
    );
  });
}
