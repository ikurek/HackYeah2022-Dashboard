import 'package:admin/models/RecentFile.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class FinfluencersList extends StatelessWidget {
  const FinfluencersList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: DataTable2(
        columnSpacing: 1,
        minWidth: 700,
        columns: [
          DataColumn(label: Text("Nazwa", style: boldTextStyle)),
          DataColumn2(
            fixedWidth: 200,
              label: Text("Średni wynik szkodliwości", style: boldTextStyle)),
          DataColumn2(
            fixedWidth: 250,
              label: Text("Poziom niebezpieczeństwa społecznego",
                  style: boldTextStyle)),
        ],
        rows: List.generate(
          demoRecentFiles.length,
          (index) => recentFileDataRow(demoRecentFiles[index]),
        ),
      ),
    );
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
        DataCell(ScoreBox(4)),
        DataCell(InfluenceBox(5))
      ],
    );
  }

  Widget ScoreBox(int score) {
    return Center( child: Container(

      alignment: Alignment.center,
      width: 30,
      height: 30,
      padding: EdgeInsets.only(left: 2, top: 2),
      child: Text(score.toString(),
          style: defaultTextStyle.copyWith(
              fontWeight: FontWeight.w700, color: Colors.white)),
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: ScoreBoxColor(score)),
    ));
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
    return Center(
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
}
