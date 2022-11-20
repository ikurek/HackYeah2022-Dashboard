import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../controllers/MenuController.dart';
import '../components/posts_table.dart';
import '../components/profile_card.dart';
import '../components/my_fields.dart';
import '../components/storage_details.dart';
import 'package:provider/provider.dart';


class MetricsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MetricsScreenState();
}

class _MetricsScreenState extends State<MetricsScreen> {
  List<_DonutChartData> predictionChartData = [
    _DonutChartData('Wysokie', 5, redColor),
    _DonutChartData('Średnie', 10, orangeColor),
    _DonutChartData('Niskie', 80, greenColor)
  ];

  List<_DonutChartData> labeledHighPredictionChartData = [
    _DonutChartData('Predykcje poprawne', 20, Color(0xFFAC2D25)),
    _DonutChartData('Błędne predykcje', 5, Color(0xFFD43232)),
    _DonutChartData('Brak weryfykacji', 80, Color(0xFFEA9999))
  ];

  List<_DonutChartData> labeledMediumPredictionChartData = [
    _DonutChartData('Predykcje poprawne', 20, Color(0xFFC87902)),
    _DonutChartData('Błędne predykcje', 20, Color(0xFFF9AA34)),
    _DonutChartData('Brak weryfykacji', 80, Color(0xFFFCD499))
  ];

  List<_LineChartData> lineChartData = [
    _LineChartData("Pn", 10, 18, redColor, orangeColor),
    _LineChartData("Wt", 4, 8, redColor, orangeColor),
    _LineChartData("Śr", 12, 8, redColor, orangeColor),
    _LineChartData("Czw", 14, 16, redColor, orangeColor),
    _LineChartData("Pt", 5, 7, redColor, orangeColor),
    _LineChartData("Sb", 13, 11, redColor, orangeColor),
    _LineChartData("Nd", 10, 8, redColor, orangeColor),
  ];


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
            _getContent(context)
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
    return Wrap(

        children: [_predictionChart(context), _badLabelPredictionChart(context), _mediumPredictedChart(context), _lineChart(context)]);
  }

  Widget _predictionChart(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
      ),
      margin: EdgeInsets.all(10),
      width: 400,
      height: 400,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 10),
          Text("Predykcje wśród wszystkich postów", style: defaultTextStyle.copyWith(fontSize: 22)),
          Expanded(child: SfCircularChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <DoughnutSeries<_DonutChartData, String>>[
                DoughnutSeries<_DonutChartData, String>(
                    dataSource: predictionChartData,
                    xValueMapper: (_DonutChartData data, _) => data.x,
                    yValueMapper: (_DonutChartData data, _) => data.y,
                    pointColorMapper: (_DonutChartData data, _) => data.color)
              ]))
        ],
      ),
    );
  }

  Widget _badLabelPredictionChart(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
      ),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      width: 400,
      height: 400,
      child: Column(
        children: [
          SizedBox(height: 10),
          Text("Udział potwierdzonych predykcji wysokiego ryzyka", style: defaultTextStyle.copyWith(fontSize: 22)),
          Expanded(child: SfCircularChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <DoughnutSeries<_DonutChartData, String>>[
                DoughnutSeries<_DonutChartData, String>(
                    dataSource: labeledHighPredictionChartData,
                    xValueMapper: (_DonutChartData data, _) => data.x,
                    yValueMapper: (_DonutChartData data, _) => data.y,
                    pointColorMapper: (_DonutChartData data, _) => data.color)
              ]))
        ],
      ),
    );
  }

  Widget _mediumPredictedChart(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
      ),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      width: 400,
      height: 400,
      child: Column(
        children: [
          SizedBox(height: 10),
          Text("Udział potwierdzonych predykcji średniego ryzyka", style: defaultTextStyle.copyWith(fontSize: 22)),
          Expanded(child: SfCircularChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <DoughnutSeries<_DonutChartData, String>>[
                DoughnutSeries<_DonutChartData, String>(
                    dataSource: labeledMediumPredictionChartData,
                    xValueMapper: (_DonutChartData data, _) => data.x,
                    yValueMapper: (_DonutChartData data, _) => data.y,
                    pointColorMapper: (_DonutChartData data, _) => data.color)
              ]))
        ],
      ),
    );
  }

  Widget _lineChart(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
      ),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      width: 1240,
      height: 400,
      child: Column(
        children: [
          SizedBox(height: 10),
          Text("Ilość scamów w danych dniach", style: defaultTextStyle.copyWith(fontSize: 22)),
          Expanded(child: SfCartesianChart(
            plotAreaBorderWidth: 0,
            legend: Legend(isVisible: true),
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
            ),
            primaryYAxis: NumericAxis(
                rangePadding: ChartRangePadding.none,
                axisLine: const AxisLine(width: -45),
                majorTickLines: const MajorTickLines(size: 0)),
            series: _getStackedLine100Series(),
            tooltipBehavior: TooltipBehavior(enable: true),
          ))
        ],
      ),
    );
  }
  List<ChartSeries<_LineChartData, String>> _getStackedLine100Series() {
    return <ChartSeries<_LineChartData, String>>[
      StackedLineSeries<_LineChartData, String>(
          dataSource: lineChartData,
          xValueMapper: (_LineChartData sales, _) => sales.name,
          yValueMapper: (_LineChartData sales, _) => sales.highValue,
          pointColorMapper: (_LineChartData sales, _) => sales.color,
          name: 'Wysokie ryzyko',
          color: redColor,
          markerSettings: const MarkerSettings(isVisible: true)),
      StackedLineSeries<_LineChartData, String>(
          dataSource: lineChartData,
          xValueMapper: (_LineChartData sales, _) => sales.name,
          yValueMapper: (_LineChartData sales, _) => sales.mediumValue,
          pointColorMapper: (_LineChartData sales, _) => sales.color2,
          name: 'Srednie ryzyko',
          color: orangeColor,
          markerSettings: const MarkerSettings(isVisible: true))];
  }

}

class _DonutChartData {
  _DonutChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}

class _LineChartData {
  _LineChartData(this.name, this.highValue, this.mediumValue, this.color, this.color2);
  final String name;
  final int highValue;
  final int mediumValue;
  final Color color;
  final Color color2;
}
