import 'package:admin/models/FinfluencersDateFilter.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../controllers/MenuController.dart';
import '../components/posts_table.dart';
import '../components/profile_card.dart';
import '../components/my_fields.dart';
import '../components/storage_details.dart';
import 'package:provider/provider.dart';

import 'components/fifnluencers_list.dart';
import 'components/finfluencers_search_filter_list.dart';


class FinfluencersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FinfluencersScreenState();
}

class _FinfluencersScreenState extends State<FinfluencersScreen> {
  FinfluencersDateFilter _finfluencersDateFilter = FinfluencersDateFilter
      .ONE_DAY;


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
            onPressed: context
                .read<MenuController>()
                .controlMenu,
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
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "Top finfluencerów",
                    style: boldTextStyle.copyWith(fontSize: 30),
                  )),
              Container(
                  padding: EdgeInsets.only(left: 20, top: 5, bottom: 20),
                  child: Text(
                    "Lista finfluencerów o najwyższym scorze niebezpieczeństwa podmiotu",
                    style: defaultTextStyle.copyWith(fontSize: 14),
                  )),
              FinfluencersSearchFilterList(
                  _finfluencersDateFilter, (value) {
                setState(() {
                  _finfluencersDateFilter = value;
                });
                _requestFinfluencers();
              }),
              FinfluencersList()
            ])));
  }

  _requestFinfluencers() {
    // Igor nakurwiaj masz wybrany state w _finfluencersDateFilter
  }
}
