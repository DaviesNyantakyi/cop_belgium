import 'package:cop_belgium/models/fasting_model.dart';
import 'package:dart_date/dart_date.dart';

class FormalDates {
  static String formatDmyy({required DateTime? date}) {
    // 26 Jan 22
    return date!.format('dd MMM yy');
  }

  static String formatEDmyyyy({required DateTime? date}) {
    // Wed, 26 Jan 22
    return date!.format('E, dd MMM yyyy');
  }

  static String formatDmyyyy({required DateTime? date}) {
    // Wed, 26 Jan 2022
    return date!.format('dd MMM yyyy');
  }

  static String formatEDmyyyyHm({required DateTime? date}) {
    // Wed, 26 Jan 2022 - 21:00
    return date!.format('E, dd MMM yyyy - hh:mm');
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

  static String getEpisodeDuration({required Duration duration}) {
    // formats the episode duration in hh:mm:ss
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    // return mm:ss if the duration is less then one hour

    if (duration.inHours < 1) {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static String getFastGoalDate({
    required FastingInfo? fastingInfo,
  }) {
    return fastingInfo!.startDate!
        .add(Duration(seconds: fastingInfo.duration.inSeconds))
        .format('dd MMM H:mm');
  }
}
