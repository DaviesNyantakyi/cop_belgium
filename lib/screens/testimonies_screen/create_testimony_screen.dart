import 'package:cop_belgium/utilities/color_picker.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateTestimonyScreen extends StatefulWidget {
  static String createTestimonyScreen = 'editTestimonyScreen';

  final Color? backgroundColor;
  final String? title;
  final String? text;

  // changes the view to editable screen
  final bool? editable;

  const CreateTestimonyScreen({
    Key? key,
    this.backgroundColor = kBlueLight2,
    this.title,
    this.text,
    this.editable = false,
  }) : super(key: key);

  @override
  State<CreateTestimonyScreen> createState() => _CreateTestimonyScreenState();
}

class _CreateTestimonyScreenState extends State<CreateTestimonyScreen> {
  String? testimonyTitle;
  String? testimonyText;
  Color? color;

  @override
  void initState() {
    super.initState();

    color = widget.backgroundColor;
    testimonyTitle = widget.title;
    testimonyText = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: _buildAppbar(editable: widget.editable!),
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

  dynamic _buildAppbar({required bool editable}) {
    return AppBar(
      title: !editable
          ? const Text(
              'Create Testimony',
              style: kSFCaptionBold,
            )
          : const Text(
              'Edit Testimony',
              style: kSFCaptionBold,
            ),
      backgroundColor: color,
      leading: TextButton(
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            FontAwesomeIcons.chevronLeft,
            color: kBlueDark,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        Container(
          alignment: Alignment.center,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.only(right: kAppbarPadding),
            ),
            child: Text(
              editable
                  ? 'Save'
                  : 'Post', // screen is editable show Save instead of post
              style: kSFCaptionBold,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        editable
            ? Container(
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(right: kAppbarPadding),
                  ),
                  child: Text(
                    'Delete',
                    style: kSFCaptionBold.copyWith(color: kRed),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            : Container(),
      ],
    );
  }
}
