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
  EngineFilter _selectedEngineFilter = EngineFilter.SMART;
  HarmFilter _selectedHarmFilter = HarmFilter.NONE;
  bool _searchInOtherLanguages = false;
  List<Post> _allPosts = List.empty();
  List<Post> _visiblePosts = List.empty();


  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  void fetchPosts() async {
    List<Post> search = await ApiRepository.searchPosts(
        smartSearchQuery:
        _selectedEngineFilter == EngineFilter.SMART ? _searchQuery : '',
        keyword:
        _selectedEngineFilter == EngineFilter.KEY_WORD ? _searchQuery : '',
        authorUsername:
        _selectedEngineFilter == EngineFilter.AUTHOR ? _searchQuery : '',
        from: _fromDate,
        to: _toDate
    );

    List<Post> filteredPosts = _allPosts.where((post) =>
    post.fraudScore! >= _selectedHarmFilter.rangeStart() &&
        post.fraudScore! <= _selectedHarmFilter.rangeEnd()).toList();

    if (_selectedEngineFilter != EngineFilter.SMART) {
      filteredPosts.sort((a, b) => b.fraudScore!.compareTo(a.fraudScore!));
    }

    setState(() {
      _allPosts = search;
      _visiblePosts = filteredPosts;
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
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Szukaj wśród tweetów",
                    style: boldTextStyle.copyWith(fontSize: 30),
                  )),
              SearchField(
                      (value) => onSearchChanged(value),
                      () => onSearchClick(),
                      (value) => onDateRangePickerSelectionChanged(value),
                  formatDateRange(),
                  _selectedEngineFilter,
                      (value) => onEngineFilterChanged(value),
                  _selectedHarmFilter,
                      (value) => onHarmFilterChanged(value),
                  _searchInOtherLanguages,
                      (value) => onSearchInOtherLanguagesChanged(value)),
              PostsTable(posts: _visiblePosts)
            ])));
  }

  String? formatDateRange() {
    if (_fromDate != null && _toDate != null) {
      return "${_fromDate!.day}.${_fromDate!.month}.${_fromDate!
          .year} - ${_toDate!.day}.${_toDate!.month}.${_toDate!.year}";
    } else {
      return null;
    }
  }

  void onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  void onSearchClick() {
    print("Search click");
    fetchPosts();
  }

  void onDateRangePickerSelectionChanged(
      DateRangePickerSelectionChangedArgs value) {
    setState(() {
      _fromDate = (value.value as PickerDateRange).startDate;
      _toDate = (value.value as PickerDateRange).endDate;
    });
    fetchPosts();
  }

  void onEngineFilterChanged(EngineFilter value) {
    print("Setting engine ${value}");
    setState(() {
      _selectedEngineFilter = value;
    });
    fetchPosts();
  }

  void onHarmFilterChanged(HarmFilter value) {
    print("Setting filter ${value}");
    setState(() {
      _selectedHarmFilter = value;
    });
    fetchPosts();
  }

  void onSearchInOtherLanguagesChanged(bool value) {
    setState(() {
      _searchInOtherLanguages = value;
    });
    fetchPosts();
  }
}
