import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';

class DatePicker {
  Future<void> showDatePicker({
    required CupertinoDatePickerMode mode,
    required DateTime initialDate, // handy for time selection after date.
    required BuildContext context,
    required Function(DateTime) onChanged,
    DateTime? maxDate,
  }) async {
    FocusScope.of(context).requestFocus(FocusNode());

    await showMyBottomSheet(
      isDismissible: false,
      context: context,
      enableDrag: false,
      fullScreenHeight: null,
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: mode,
                initialDateTime: initialDate,
                maximumDate: maxDate ?? kMaxDate,
                maximumYear: maxDate?.year ?? kMaxDate.year,
                minimumDate: kMinDate,
                minimumYear: kMinDate.year,
                onDateTimeChanged: onChanged,
                use24hFormat: true,
              ),
            ),
            Buttons.buildButton(
              context: context,
              btnText: 'Done',
              height: kButtonHeight,
              width: double.infinity,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
