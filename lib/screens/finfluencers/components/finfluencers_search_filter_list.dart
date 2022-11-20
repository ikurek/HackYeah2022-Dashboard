import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/FinfluencersDateFilter.dart';

class FinfluencersSearchFilterList extends StatelessWidget {

  final ValueChanged<FinfluencersDateFilter> _finfluencersDateChanged;
  final FinfluencersDateFilter _finfluencersDateFilter;

  FinfluencersSearchFilterList(this._finfluencersDateFilter,
      this._finfluencersDateChanged);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(child: Text("Zakres czasowy", style: defaultTextStyle.copyWith(fontSize: 11)), margin: EdgeInsets.only(left: 20)),
    Container(child: Row(children: FinfluencersDateFilter.values.map((e) => getChips(e)).toList()), margin: EdgeInsets.only(left: 15))
    ]);
  }

  Widget getChips(FinfluencersDateFilter finfluencersDateFilter) {
    if (_finfluencersDateFilter == finfluencersDateFilter) {
      return getSelectedChips(finfluencersDateFilter);
    } else {
      return getUnselectedChips(finfluencersDateFilter);
    }
  }

  Widget getSelectedChips(FinfluencersDateFilter finfluencersDateFilter) {
    return
      InkWell(
          onTap: () {
            _finfluencersDateChanged.call(finfluencersDateFilter);
          }, child:
      Container(
          alignment: Alignment.center,
          width: 80,
          height: 30,
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.only(left: 2, top: 2),
          child: Text(getChipsName(finfluencersDateFilter),
              style: defaultTextStyle.copyWith( color: selectedTextColor)),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(2)),
              color: selectedMenuItemColor)));
  }

  Widget getUnselectedChips(FinfluencersDateFilter finfluencersDateFilter) {
    return InkWell(
        onTap: () {
          _finfluencersDateChanged.call(finfluencersDateFilter);
        }, child: Container(
        alignment: Alignment.center,
        width: 80,
        height: 30,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(left: 2, top: 2),
        child: Text(getChipsName(finfluencersDateFilter),
            style: defaultTextStyle.copyWith(color: selectedMenuItemColor)),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(2)),
            border: Border.all(color: selectedMenuItemColor, width: 1.0))));
  }

  String getChipsName(FinfluencersDateFilter finfluencersDateFilter) {
    switch (finfluencersDateFilter) {
      case FinfluencersDateFilter.SIX_HOURS:
        return "6 godzin";
      case FinfluencersDateFilter.TWELVE_HOURS:
        return "12 godzin";
      case FinfluencersDateFilter.ONE_DAY:
        return "1 dzień";
      case FinfluencersDateFilter.ONE_WEEK:
        return "1 tydzień";
      case FinfluencersDateFilter.ONE_MONTH:
        return "1 miesiąc";
    }
  }

}