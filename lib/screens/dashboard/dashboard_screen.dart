import 'package:admin/api/ApiRepository.dart';
import 'package:admin/models/Post.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../controllers/MenuController.dart';
import '../components/my_fields.dart';
import '../components/profile_card.dart';
import '../components/recent_files.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    test();
  }

  void test() async {
    List<Post> posts = await ApiRepository.getPosts();
    print(posts);
    Post post = await ApiRepository.getPost(1);
    print(post);
    List<Post> search = await ApiRepository.searchPosts();
    print(search);
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
    return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Szukaj wśród twitów",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          RecentFiles()
        ]));
  }
}
