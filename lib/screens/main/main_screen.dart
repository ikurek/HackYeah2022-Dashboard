import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/finfluencers/finfluencers_screen.dart';
import 'package:admin/screens/metrics/metrics_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu((value) {
        setState(() {
          _selectedPage = value;
        });
      }),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu((value) {
                  setState(() {
                    _selectedPage = value;
                  });
                }),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: _getScreenChild(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getScreenChild() {
    switch (_selectedPage) {
      case 0:
        return DashboardScreen();
      case 1:
        return FinfluencersScreen();
      case 2:
        return MetricsScreen();
      default:
        return DashboardScreen();
    }
  }
}
