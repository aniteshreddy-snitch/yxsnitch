import 'package:flutter/material.dart';
import 'package:yxsnitch/dashboard/dashboard.dart';
import 'package:yxsnitch/components/constants.dart';
import 'package:yxsnitch/components/my_app_bar.dart';
import 'package:yxsnitch/homepage/components/alert_logout.dart';
import 'package:yxsnitch/placeholder.dart';
import 'package:yxsnitch/Organisation/organisation_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late double screenWidth;
  final List<Widget> _pages = [
    const DashBoard(),
    const GroupPage(),
    const CategoriesPage(),
    const PoliciesPage(),
    const OrganisationPage()
  ];

  void _onItemTapped(int index, bool close) {
    setState(() {
      _selectedIndex = index;
    });
    if (close) {
      Navigator.pop(
          context); // Close the drawer after selection on tablet and mobile mode
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      screenWidth = constraints.maxWidth;
      return Scaffold(
        appBar: myAppBar(greenColor, screenWidth),
        // [screenWidth] greater 1150 pixels then drawer will stay open by default(desktop)
        drawer: screenWidth < 1150 ? homePageDrawer() : null,
        body: screenWidth < 1150
            //[screenWidth] greater 1150 pixels then drawer will stay open by
            // default and have the vertical divider or else just show the table
            ? _pages[_selectedIndex]
            : Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: homePageDrawer(),
                  ),
                  const VerticalDivider(
                    width: 20,
                    thickness: 1,
                    indent: 20,
                    endIndent: 0,
                    color: Colors.grey,
                  ),
                  Expanded(
                    flex: 4,
                    child: _pages[_selectedIndex],
                  ),
                ],
              ),
      );
    });
  }

  Drawer homePageDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DrawerHeader(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(20),
            child: Row(children: [
              Icon(Icons.security_outlined),
              SizedBox(width: 10),
              Text(
                "Snitch Server",
                style: TextStyle(fontSize: 24),
              )
            ]),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            selected: _selectedIndex == 0,
            selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.1),
            selectedColor: Theme.of(context).primaryColor,
            onTap: () => _onItemTapped(0, screenWidth < 1150),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Group'),
            selected: _selectedIndex == 1,
            selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.1),
            selectedColor: Theme.of(context).primaryColor,
            onTap: () => _onItemTapped(1, screenWidth < 1150),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categories'),
            selected: _selectedIndex == 2,
            selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.1),
            selectedColor: Theme.of(context).primaryColor,
            onTap: () => _onItemTapped(2, screenWidth < 1150),
          ),
          ListTile(
            leading: const Icon(Icons.policy_outlined),
            title: const Text('Policies'),
            selected: _selectedIndex == 3,
            selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.1),
            selectedColor: Theme.of(context).primaryColor,
            onTap: () => _onItemTapped(3, screenWidth < 1150),
          ),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Organisation'),
            selected: _selectedIndex == 4,
            selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.1),
            selectedColor: Theme.of(context).primaryColor,
            onTap: () => _onItemTapped(4, screenWidth < 1150),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            // selected: _selectedIndex == 3,
            selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.1),
            selectedColor: Theme.of(context).primaryColor,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return logoutDialog(context);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
