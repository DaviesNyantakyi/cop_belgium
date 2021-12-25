import 'package:cop_belgium/models/fasting_model.dart';
import 'package:dart_date/src/dart_date.dart';

class FormalDates {
  static String formatDm({required DateTime? date}) {
    return date!.format('dd MMM H:mm');
  }

  static String formatDmy({required DateTime? date}) {
    return date!.format('dd MMM yy');
  }

  static String formatHm({required DateTime? date}) {
    return date!.format('HH:mm');
  }

  static String formatMs({required DateTime? date}) {
    return date!.format('mm:ss');
  }

  static String getFastGoalDate({
    required FastingInfo? fastingInfo,
  }) {
    return fastingInfo!.startDate!
        .add(Duration(seconds: fastingInfo.duration.inSeconds))
        .format('dd MMM H:mm');
  }
}
