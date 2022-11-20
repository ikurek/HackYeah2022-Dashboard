import 'package:admin/responsive.dart';
import 'package:admin/screens/components/search_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../controllers/MenuController.dart';
import '../components/profile_card.dart';
import '../components/recent_files.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          _getHeader(context),
          SizedBox(height: defaultPadding),
          _getContent(context)
        ],
      ),
    ));
  }

  Widget _getHeader(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            color: textColor,
            onPressed: context.read<MenuController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SizedBox()),
        ProfileCard()
      ],
    );
  }

  Widget _getContent(BuildContext context) {
    return Flexible(
        child: Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: secondaryColor,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Szukaj wśród twitów",
                    style: boldTextStyle.copyWith(fontSize: 30),
                  )),
              SearchField(
                  (value) {}, (dateRangePickerSelectionChangedArgs) {}, null),
              RecentFiles()
            ])));
  }
}
