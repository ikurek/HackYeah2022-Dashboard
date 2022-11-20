import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../constants.dart';
import '../../models/EngineFilter.dart';
import '../../models/HarmFilter.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String> _valueChanged;
  final DateRangePickerSelectionChangedCallback _dateChanged;
  final String? _dateRange;
  final EngineFilter _selectedEngineFilter;
  final ValueChanged<EngineFilter> _engineFilterChanged;
  final HarmFilter _harmFilter;
  final ValueChanged<HarmFilter> _harmFilterChanged;
  final bool _searchInOtherLanguages;
  final ValueChanged<bool> _searchInOtherLanguagesChanged;

  SearchField(this._valueChanged,
      this._dateChanged,
      this._dateRange,
      this._selectedEngineFilter,
      this._engineFilterChanged,
      this._harmFilter,
      this._harmFilterChanged,
      this._searchInOtherLanguages,
      this._searchInOtherLanguagesChanged);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [SearchInput(context), _getLanguagesToggle(context)]),
      Row(children: [
        DatePickerInput(context),
        getEngineTypePicker(),
        getHarmFilterPicker()
      ])
    ]);
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
    return Container(
        margin: EdgeInsets.only(top: 10, left: 20),
        padding: EdgeInsets.only(right: 10, left: 10),
        height: 35,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: textColor, width: 1.0)),
        child: MaterialButton(
          child: Container(
            child: _dateRange == null
                ? Text(
              'Select a date',
              style: defaultTextStyle,
            )
                : Text(_dateRange!,
                style: defaultTextStyle.copyWith(fontSize: 15)),
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: Text('Wybierz zakres dat'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Potwierdź',
                              style: defaultTextStyle.copyWith(
                                  fontSize: 15, color: primaryColor)),
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
        ));
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

  Widget getEngineTypePicker() {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 20),
        width: 150,
        height: 35,
        child: DropdownButtonFormField2(
            decoration: InputDecoration(
              //Add isDense true and zero Padding.
              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              //Add more decoration as you want here
              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
            ),
            isExpanded: true,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: textColor,
            ),
            iconSize: 30,
            value: _getEngineFilterName(_selectedEngineFilter),
            buttonHeight: 60,
            buttonPadding: const EdgeInsets.only(left: 5, right: 5),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
            ),
            items: EngineFilter.values
                .map((item) =>
                DropdownMenuItem<String>(
                  value: _getEngineFilterName(item),
                  child: Text(
                    _getEngineFilterName(item),
                    style: defaultTextStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ))
                .toList(),
            onChanged: (value) {
              _engineFilterChanged.call(value as EngineFilter);
              //Do something when changing the item if you want.
            }));
  }

  String _getEngineFilterName(EngineFilter engineFilter) {
    if (engineFilter == EngineFilter.AUTHOR) {
      return "Autor";
    } else if (engineFilter == EngineFilter.KEY_WORD) {
      return "Keyword";
    } else {
      return "Smart search";
    }
  }

  Widget getHarmFilterPicker() {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 20),
        width: 250,
        height: 35,
        child: DropdownButtonFormField2(
            decoration: InputDecoration(
              //Add isDense true and zero Padding.
              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              //Add more decoration as you want here
              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
            ),
            isExpanded: true,
            hint: Text("Szkodliwość", style: defaultTextStyle),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: textColor,
            ),
            iconSize: 30,
            value: _getHarmFilterInputName(_harmFilter),
            buttonHeight: 60,
            buttonPadding: const EdgeInsets.only(left: 5, right: 5),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
            ),
            items: HarmFilter.values
                .map((item) =>
                DropdownMenuItem<String>(
                  value: _getHarmFilterName(item),
                  child: Text(
                    _getHarmFilterName(item),
                    style: defaultTextStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ))
                .toList(),
            onChanged: (value) {
              _harmFilterChanged.call(value as HarmFilter);
              //Do something when changing the item if you want.
            }));
  }

  String _getHarmFilterName(HarmFilter harmFilter) {
    if (harmFilter == HarmFilter.NONE) {
      return "--Brak--";
    } else if (harmFilter == HarmFilter.HIGH) {
      return "Wysoka szkodliwość";
    } else if (harmFilter == HarmFilter.MEDIUM) {
      return "Średnia szkodliwość";
    } else {
      return "Niska szkodliwość";
    }
  }

  String? _getHarmFilterInputName(HarmFilter harmFilter) {
    if (harmFilter == HarmFilter.NONE) {
      return null;
    } else if (harmFilter == HarmFilter.HIGH) {
      return "Wysoka szkodliwość";
    } else if (harmFilter == HarmFilter.MEDIUM) {
      return "Średnia szkodliwość";
    } else {
      return "Niska szkodliwość";
    }
  }

  Widget _getLanguagesToggle(BuildContext) {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 20), child: Row(children: [
      Text("Szukaj frazy w innych językach",
          style: defaultTextStyle.copyWith(fontSize: 17)),
      SizedBox(width: 10),
      FlutterSwitch(
          width: 60.0,
          height: 35.0,
          valueFontSize: 12.0,
          toggleSize: 25.0,
          activeColor: selectedMenuItemColor,
          value: _searchInOtherLanguages,
          borderRadius: 30.0,
          padding: 8.0,
          onToggle: (val) {
            print(val);
            _searchInOtherLanguagesChanged.call(val);
          }
      )
    ]));
  }
}
