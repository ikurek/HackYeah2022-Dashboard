import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../constants.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String> _valueChanged;
  final DateRangePickerSelectionChangedCallback _dateChanged;
  final String? _dateRange;

  SearchField(this._valueChanged, this._dateChanged, this._dateRange);

  @override
  Widget build(BuildContext context) {
    return Column(children: [SearchInput(context), DatePickerInput(context)]);
  }

  Widget SearchInput(BuildContext context) {
    return Container(
        width: 400,
        padding: EdgeInsets.only(left: 20, top: 10),
        height: 65,
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search",
            fillColor: secondaryColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(0)),
            ),
            suffixIcon: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                decoration: BoxDecoration(
                  color: selectedMenuItemColor,
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                child: SvgPicture.asset("assets/icons/Search.svg"),
              ),
            ),
          ),
          onChanged: (value) {
            _valueChanged.call(value);
          },
        ));
  }

  Widget DatePickerInput(BuildContext context) {
    return MaterialButton(
      child: Container(
        child: _dateRange == null
            ? Text(
                'Select a date',
                style: defaultTextStyle,
              )
            : Text(_dateRange!, style: defaultTextStyle),
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text('Wybierz zakres dat'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Potwierdź', style: defaultTextStyle.copyWith(fontSize: 15, color: primaryColor)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                  content: Container(
                    height: 300,
                    child: getDateRangePicker(),
                  ));
            });
      },
    );
  }

  Widget getDateRangePicker() {
    return Container(
        height: 250,
        width: 300,
        child: Card(
            child: SfDateRangePicker(
          view: DateRangePickerView.month,
          selectionMode: DateRangePickerSelectionMode.range,
          onSelectionChanged: _dateChanged,
        )));
  }
}
