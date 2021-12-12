import 'package:cop_belgium/utilities/color_picker.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:flutter/material.dart';

String _text =
    '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. In placerat adipiscing nulla tempus facilisi. Semper tempor eu a, libero magnis.

Egestas amet, at sit dapibus tortor, lacus orci aliquet. Odio elit vitae sagittis ac sem aenean nisl pretium sagittis. Vitae hac dictum faucibus fringilla faucibus morbi. Sed nisl tempus est vulputate enim convallis consectetur. Convallis eget lacus, integer enim accumsan.

Mollis sed faucibus volutpat accumsan justo tempor lectus eu quis. Interdum adipiscing et quam nunc elementum volutpat eu. Diam nibh sit lobortis nisl scelerisque eu. Odio pulvinar quis vitae ut. Justo lacus vitae pretium dolor sed cursus venenatis.''';

class EditTestimonyScreen extends StatefulWidget {
  static String editTestimonyScreen = 'editTestimonyScreen';
  const EditTestimonyScreen({Key? key}) : super(key: key);

  @override
  State<EditTestimonyScreen> createState() => _EditTestimonyScreenState();
}

class _EditTestimonyScreenState extends State<EditTestimonyScreen> {
  String? testimonyTitle;
  String? testimonyText;
  Color? color = kBlueLight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: _buildAppbar(
        onTapBack: () {
          Navigator.pop(context);
        },
        onTapSave: () {
          debugPrint('Save');
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kBodyPadding,
              vertical: kBodyPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FastColorPicker(
                  onColorSelected: (value) {
                    color = value;
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                _buildTF(
                  initialValue: testimonyTitle,
                  hintText: 'Testimony Title',
                  style: kSFHeadLine1,
                  onChanged: (value) {
                    testimonyTitle = value;
                    debugPrint(testimonyTitle);
                  },
                ),
                const SizedBox(height: 16),
                _buildTF(
                  initialValue: testimonyText,
                  style: kSFBody,
                  hintText: 'Your testimony',
                  onChanged: (value) {
                    testimonyText = value;
                    debugPrint(testimonyText);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTF({
    String? initialValue,
    String? hintText,
    TextStyle? style,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      initialValue: initialValue,
      style: style,
      minLines: 1,
      cursorWidth: 3,
      cursorColor: kBlueDark,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
      ),
      onChanged: onChanged,
    );
  }

  dynamic _buildAppbar({
    VoidCallback? onTapBack,
    VoidCallback? onTapSave,
  }) {
    return AppBar(
      backgroundColor: color,
      leading: InkWell(
        splashColor: kBlueLight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/icons/arrow_left_icon.png',
          ),
        ),
        onTap: onTapBack,
      ),
      actions: [
        Container(
          alignment: Alignment.center,
          child: InkWell(
            splashColor: kBlueLight,
            child: Padding(
              padding: EdgeInsets.all(kAppbarPadding).copyWith(right: 20),
              child: Text(
                'Save',
                style: kSFBody,
              ),
            ),
            onTap: onTapSave,
          ),
        ),
      ],
    );
  }
}
