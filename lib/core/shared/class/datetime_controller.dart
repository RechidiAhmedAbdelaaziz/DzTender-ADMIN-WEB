import 'package:flutter/widgets.dart';

class DateTimeController extends TextEditingController {
  DateTimeController({this.dateTime})
      : super(text: dateTime?.toIso8601String() ?? 'RECHIDI');

  final DateTime? dateTime;
}
