import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class SideMenu extends StatelessWidget {
  final ValueChanged<int> _pageChanged;
  final int _selectedPage;

  SideMenu(this._pageChanged, this._selectedPage);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
              height: 80,
              child: DrawerHeader(
                child: SvgPicture.asset("assets/icons/logo.svg"),
              )),
          Divider(
            height: 1,
            color: lineColor,
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            isSelected: _selectedPage == 0,
            press: () {
              _pageChanged.call(0);
            },
          ),
          Divider(
            height: 1,
            color: lineColor,
          ),
          DrawerListTile(
            title: "Finfluencerzy",
            svgSrc: "assets/icons/menu_tran.svg",
            isSelected: _selectedPage == 1,
            press: () {
              _pageChanged.call(1);
            },
          ),
          Divider(
            height: 1,
            color: lineColor,
          ),
          DrawerListTile(
            title: "Glabalne metryki",
            svgSrc: "assets/icons/menu_task.svg",
            isSelected: _selectedPage == 2,
            press: () {
              _pageChanged.call(2);
            },
          ),
          Divider(
            height: 1,
            color: lineColor,
          )
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {Key? key,
      // For selecting those three line once press "Command+D"
      required this.title,
      required this.svgSrc,
      required this.press,
      required this.isSelected})
      : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: _getBackgroundColor(),
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: _getTextColor(),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: _getTextColor()),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (isSelected) {
      return selectedMenuItemColor;
    } else {
      return alphaColor;
    }
  }

  Color _getTextColor() {
    if (isSelected) {
      return selectedTextColor;
    } else {
      return textColor;
    }
  }
}
