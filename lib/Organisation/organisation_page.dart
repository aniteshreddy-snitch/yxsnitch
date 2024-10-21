import 'package:flutter/material.dart';
import 'package:yxsnitch/Organisation/organisationDetails/bloc/organisation_bloc.dart';
import 'package:yxsnitch/Organisation/organisationDetails/widgets/organisation_details.dart';
import 'package:yxsnitch/Organisation/userDetails/bloc/user_details_bloc.dart';
import 'package:yxsnitch/Organisation/userDetails/widgets/user_details.dart';
import 'package:yxsnitch/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yxsnitch/components/utils/network/auth_service.dart';

class OrganisationPage extends StatefulWidget {
  const OrganisationPage({super.key});

  @override
  OrganisationPageState createState() => OrganisationPageState();
}

class OrganisationPageState extends State<OrganisationPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final AuthService _authService = AuthService();
  bool isOwner = false;
  Map<String, dynamic> organisationData = {};
  List<Map<String, dynamic>> usersData = [];
  UserDetailsBloc userDetailsBloc = UserDetailsBloc();

  @override
  void initState() {
    super.initState();
    _loadData();
    tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _loadData() async {
    // Simulate API call to get organisation and users data

    // Get owner status from AuthService
    final ownerStatus = await _authService.getOwner();
    setState(() {
      isOwner = ownerStatus == true;
    });
    // tabController = TabController(length: isOwner ? 3 : 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Organisation Details')),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              lazy: false,
              create: (context) =>
                 userDetailsBloc..add(GetUserDetailsEvent())),
          BlocProvider(
              lazy: false,
              create: (context) =>
                  OrganisationBloc()..add(OrganisationFetchEvent())),
        ],
        child: NestedScrollView(
            floatHeaderSlivers: true,
            // physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, value) {
              return [
                SliverToBoxAdapter(
                  child: Center(child: mainHeader('Organisation')),
                ),
                SliverToBoxAdapter(
                  child: TabBar(
                    isScrollable: true,
                    controller: tabController,
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: const [
                      Tab(text: 'Organisation'),
                      Tab(text: 'Users'),
                    ],
                    labelColor: Colors.black,
                  ),
                ),
              ];
            },
            body: TabBarView(controller: tabController, children: [
              OrganisationDetailsCard(
                isOwner: isOwner,
              ),
              UserDetailsColumn(
                isOwner: isOwner,
              ),
            ])),
      ),
    );
  }
}
