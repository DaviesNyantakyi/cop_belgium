import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EaslyLoadingIndicator {
  static Future<void> showLoading() async {
    await EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
      indicator: kProgressIndicator,
    );
  }

  static Future<void> dismissLoading() async {
    await EasyLoading.dismiss();
  }
}
