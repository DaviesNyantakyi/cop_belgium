import 'package:cop_belgium/models/fasting_model.dart';
import 'package:dart_date/src/dart_date.dart';

class FormalDates {
  static String getStartDate({required DateTime date}) {
    return date.format('dd MMM H:mm');
  }

  static String getEndDate({
    required DateTime date,
    required FastingInfo? fastingInfo,
  }) {
    return date
        .add(Duration(seconds: fastingInfo!.duration!.inSeconds))
        .format('dd MMM H:mm');
  }
}