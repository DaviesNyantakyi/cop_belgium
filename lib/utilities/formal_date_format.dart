import 'package:cop_belgium/models/fasting_model.dart';
import 'package:dart_date/dart_date.dart';

class FormalDates {
  static String formatDmyy({required DateTime? date}) {
    // 26 Jan 22
    return date!.format('dd MMM yy');
  }

  static String formatEDmy({required DateTime? date}) {
    // Wed, 26 Jan 22
    return date!.format('E, dd MMM yy');
  }

  static String formatDmyyyy({required DateTime? date}) {
    return date!.format('dd MMM yyyy');
  }

  static String formatEDmyHm({required DateTime? date}) {
    // Wed, 26 Jan 22
    return date!.format('E, dd MMM yy - hh:mm');
  }

  static String formatHm({required DateTime? date}) {
    return date!.format('HH:mm');
  }

  static String formatMs({required DateTime? date}) {
    return date!.format('mm:ss');
  }

  static String formatHms({required DateTime? date}) {
    return date!.format('hh:mm:ss');
  }

  static String calculateEpisodeTime({required DateTime? date}) {
    // returns the format H:m:s is the audio length is more then one our
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
