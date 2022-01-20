import 'package:cop_belgium/models/fasting_model.dart';
import 'package:dart_date/dart_date.dart';

class FormalDates {
  static String formatDm({required DateTime? date}) {
    return date!.format('dd MMM H:mm');
  }

  static String formatDmy({required DateTime? date}) {
    return date!.format('dd MMM yy');
  }

  static String formatDmyHm({required DateTime? date}) {
    return date!.format('dd MMM yy - HH:mm');
  }

  static String formatHm({required DateTime? date}) {
    return date!.format('HH:mm');
  }

  static String formatMs({required DateTime? date}) {
    // check if the duration is greater then 60 min the return hour format

    return date!.format('mm:ss');
  }

  static String formatHms({required DateTime? date}) {
    // check if the duration is greater then 60 min the return hour format
    return date!.format('hh:mm:ss');
  }

  static String calculateTime({required DateTime? date}) {
    if (date!.hour <= 1) {
      return formatMs(date: date);
    }
    return formatHms(date: date);
  }

  static String getFastGoalDate({
    required FastingInfo? fastingInfo,
  }) {
    return fastingInfo!.startDate!
        .add(Duration(seconds: fastingInfo.duration.inSeconds))
        .format('dd MMM H:mm');
  }
}
