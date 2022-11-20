import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../models/Post.dart';

class PostsTable extends StatelessWidget {
  final List<Post> posts;

  const PostsTable({
    Key? key,
    required List<Post> posts
  }) : posts = posts, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: DataTable2(
        columnSpacing: 50,
        minWidth: 500,
        dataRowHeight: 100,
        columns: [
          DataColumn2(label: Text("Konto", style: boldTextStyle), size: ColumnSize.S),
          DataColumn2(label: Text("Teść", style: boldTextStyle), fixedWidth: 500),
          DataColumn2(label: Text("Data postu", style: boldTextStyle), size: ColumnSize.S),
          DataColumn2(label: Text("Ocena", style: boldTextStyle), size: ColumnSize.S),
          DataColumn2(label: Text("Retweety", style: boldTextStyle), size: ColumnSize.S),
          DataColumn2(label: Text("Wpływ", style: boldTextStyle), size: ColumnSize.S),
          DataColumn2(label: Text("Weryfikacja", style: boldTextStyle), size: ColumnSize.S,
          ),
        ],
        rows: posts.map((post) => recentFileDataRow(post)).toList()
      ),
    );
  }
}

DataRow recentFileDataRow(Post post) {
  return DataRow(
    cells: [
      DataCell(
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: SizedBox()),
            Text(post.tweetAuthorDisplayName!,
                style: defaultTextStyle.copyWith(fontSize: 16)),
            Text(post.tweetAuthorUsername!,
                style: defaultTextStyle.copyWith(fontSize: 13)),
            Expanded(child: SizedBox())
          ],
        ),
      ),
      DataCell(Text(post.tweetText!, style: defaultTextStyle)),
      DataCell(Row(children: [
        Text(post.time(), style: defaultTextStyle),
        SizedBox(width: 5),
        Text(post.date(),
            style: defaultTextStyle.copyWith(fontWeight: FontWeight.w700))
      ])),
      DataCell(ScoreBox(post.fraudScore ?? 0)),
      DataCell(Text(
        post.retweets.toString(),
        style: defaultTextStyle,
        textAlign: TextAlign.end,
      )),
      DataCell(InfluenceBox(post.socialScore ?? 0)),
      DataCell(VerifyBox(post.manuallyReviewed))
    ],
  );
}

Widget ScoreBox(int score) {
  return Container(
    margin: EdgeInsets.only(left: 15),
    alignment: Alignment.center,
    width: 30,
    height: 30,
    padding: EdgeInsets.only(left: 2, top: 2),
    child: Text(score.toString(),
        style: defaultTextStyle.copyWith(
            fontWeight: FontWeight.w700, color: Colors.white)),
    decoration:
        BoxDecoration(shape: BoxShape.circle, color: ScoreBoxColor(score)),
  );
}

Color ScoreBoxColor(int score) {
  if (score > 8) {
    return redColor;
  } else if (score > 5) {
    return orangeColor;
  } else {
    return orangeColor;
  }
}

Widget InfluenceBox(int influenceScore) {
  return Container(
      margin: EdgeInsets.only(left: 15),
      child: Container(
          alignment: Alignment.center,
          width: 30,
          height: 30,
          padding: EdgeInsets.only(left: 2, top: 2),
          child: Text(influenceScore.toString(),
              style: defaultTextStyle.copyWith(
                  fontWeight: FontWeight.w700, color: textColor)),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: textColor, width: 2.0))));
}

Widget NegativeBox() {
  return Container(
      alignment: Alignment.center,
      width: 120,
      height: 30,
      padding: EdgeInsets.only(left: 2, top: 2),
      child: Text("Negatywna",
          style: defaultTextStyle.copyWith(
              fontWeight: FontWeight.w700, color: selectedMenuItemColor)),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          border: Border.all(color: selectedMenuItemColor, width: 2.0)));
}

Widget PositiveBox() {
  return Container(
      alignment: Alignment.center,
      width: 120,
      height: 30,
      padding: EdgeInsets.only(left: 2, top: 2),
      child: Text("Pozytywna",
          style: defaultTextStyle.copyWith(
              fontWeight: FontWeight.w700, color: selectedTextColor)),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: selectedMenuItemColor));
}

Widget NotVerifiedBox() {
  return Container(
      alignment: Alignment.center,
      width: 120,
      height: 30,
      padding: EdgeInsets.only(left: 2, top: 2),
      child: Text("Brak",
          style: defaultTextStyle.copyWith(
              fontWeight: FontWeight.w700, color: Color(0xFF808080))),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: lineColor));
}

Widget VerifyBox(bool? isVerified) {
  if (isVerified == true) {
    return PositiveBox();
  } else if (isVerified == false) {
    return NegativeBox();
  } else {
    return NotVerifiedBox();
  }
}
