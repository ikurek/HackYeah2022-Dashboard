import 'package:admin/api/ApiRepository.dart';
import 'package:admin/models/HarmFilter.dart';
import 'package:admin/models/Post.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/components/search_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../constants.dart';
import '../../controllers/MenuController.dart';
import '../../models/EngineFilter.dart';
import '../components/posts_table.dart';
import '../components/profile_card.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _searchQuery = '';
  DateTime? _toDate = null;
  DateTime? _fromDate = null;
  List<Post> _posts = List.empty();

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  void fetchPosts() async {
    List<Post> search =
        await ApiRepository.searchPosts(from: _fromDate, to: _toDate);
    setState(() {
      _posts = search;
    });
  }

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
                    "Szukaj wśród tweetów",
                    style: boldTextStyle.copyWith(fontSize: 30),
                  )),
              SearchField(
                  (value) => onSearchChanged(value),
                  (value) => onDateRangePickerSelectionChanged(value),
                  null,
                  EngineFilter.SMART,
                  (value) {},
                  HarmFilter.NONE,
                  (value) {},
                  true,
                  (value) {}),
              PostsTable(posts: _posts)
            ])));
  }

  void onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  void onDateRangePickerSelectionChanged(
      DateRangePickerSelectionChangedArgs value) {
    if (value is List<DateTime>) {
      setState(() {
        _fromDate = (value as List<DateTime>).first;
        _toDate = (value as List<DateTime>).last;
      });
    }
  }
}
