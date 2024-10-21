import 'package:flutter/material.dart';
import 'package:yxsnitch/dashboard/bloc/dashboard_bloc.dart';
import 'package:yxsnitch/dashboard/widgets/table_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  // final DashboardBloc dashboardBloc = DashboardBloc();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    // dashboardBloc.add(DashboardDeviceFetchEvent());
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(lazy: false, create: (context) => DashboardBloc()),
      BlocProvider(lazy: false, create: (context) => DashboardBloc()),
    ], child: tableViewScreen(tabController, context));
  }
}
