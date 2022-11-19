import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../controllers/MenuController.dart';
import '../components/profile_card.dart';
import '../components/search_field.dart';
import '../components/my_fields.dart';
import '../components/recent_files.dart';
import '../components/storage_details.dart';
import 'package:provider/provider.dart';


class FinfluencersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FinfluencersScreenState();
}

class _FinfluencersScreenState extends State<FinfluencersScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            _getHeader(context),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MyFiles(),
                      SizedBox(height: defaultPadding),
                      RecentFiles(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) StarageDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StarageDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
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
          Text(
            "Finfluencers",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SizedBox()),
        ProfileCard()
      ],
    );
  }
}
