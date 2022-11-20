import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Finfluencer.dart';

class FinfluencersList extends StatelessWidget {
  final List<Finfluencer> finfluencers;

  const FinfluencersList({
    Key? key,
    required this.finfluencers
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
        rows: finfluencers.map((finfluencer) => recentFileDataRow(finfluencer)).toList(),
      ),
    );
  }

  DataRow recentFileDataRow(Finfluencer finfluencer) {
    return DataRow(
      cells: [
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: SizedBox()),
              Text(finfluencer.tweetAuthorDisplayName!,
                  style: defaultTextStyle.copyWith(fontSize: 16)),
              Text(finfluencer.tweetAuthorUsername!,
                  style: defaultTextStyle.copyWith(fontSize: 13)),
              Expanded(child: SizedBox())
            ],
          ),
        ),
        DataCell(ScoreBox(finfluencer.fraudScore!.round())),
        DataCell(InfluenceBox(finfluencer.socialScore!.round()))
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
