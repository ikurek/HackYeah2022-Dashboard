import 'package:admin/models/RecentFile.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable2(
        columnSpacing: 1,
        minWidth: 700,
        columns: [
          DataColumn2(
              label: Text("Konto", style: boldTextStyle), size: ColumnSize.M),
          DataColumn(
            label: Text("Teść", style: boldTextStyle),
          ),
          DataColumn(
            label: Text("Data postu", style: boldTextStyle),
          ),
          DataColumn2(
              label: Text("Ocena", style: boldTextStyle), size: ColumnSize.S),
          DataColumn(
            label: Text("Retweety", style: boldTextStyle),
          ),
          DataColumn2(
              label: Text("Wpływ", style: boldTextStyle), size: ColumnSize.S),
          DataColumn(
            label: Text("Weryfikacja", style: boldTextStyle),
          ),
        ],
        rows: List.generate(
          demoRecentFiles.length,
          (index) => recentFileDataRow(demoRecentFiles[index]),
        ),
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: SizedBox()),
            Text(fileInfo.date!,
                style: defaultTextStyle.copyWith(fontSize: 16)),
            Text(fileInfo.date!,
                style: defaultTextStyle.copyWith(fontSize: 13)),
            Expanded(child: SizedBox())
          ],
        ),
      ),
      DataCell(Text(fileInfo.date!, style: defaultTextStyle)),
      DataCell(Row(children: [
        Text(fileInfo.size!, style: defaultTextStyle),
        SizedBox(width: 5),
        Text(fileInfo.size!,
            style: defaultTextStyle.copyWith(fontWeight: FontWeight.w700))
      ])),
      DataCell(ScoreBox(4)),
      DataCell(Text(
        fileInfo.date!,
        style: defaultTextStyle,
        textAlign: TextAlign.end,
      )),
      DataCell(InfluenceBox(5)),
      DataCell(VerifyBox(null))
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
