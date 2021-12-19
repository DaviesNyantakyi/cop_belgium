import 'package:cop_belgium/models/testimony_model.dart';
import 'package:cop_belgium/services/cloud_firestore.dart';
import 'package:cop_belgium/utilities/color_picker.dart';
import 'package:cop_belgium/utilities/color_to_hex.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateTestimonyScreen extends StatefulWidget {
  static String createTestimonyScreen = 'editTestimonyScreen';

  final Color? backgroundColor;
  final String? title;
  final String? text;

  // enabled edit mode
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
  String? userId;
  String? title;
  String? testimony;
  DateTime? date;
  Color? cardColor;

  @override
  void initState() {
    super.initState();

    cardColor = widget.backgroundColor;
    title = widget.title;
    testimony = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cardColor,
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
                    setState(() {
                      cardColor = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                _buildTF(
                  initialValue: title,
                  hintText: 'Testimony Title',
                  style: kSFHeadLine1,
                  onChanged: (value) {
                    title = value;
                  },
                ),
                const SizedBox(height: 16),
                _buildTF(
                  initialValue: testimony,
                  style: kSFBody,
                  hintText: 'Your testimony',
                  onChanged: (value) {
                    testimony = value;
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

  Widget _buildAppbarTitle() {
    if (widget.editable == false) {
      return const Text(
        'Create Testimony',
        style: kSFCaptionBold,
      );
    } else {
      return const Text(
        'Edit Testimony',
        style: kSFCaptionBold,
      );
    }
  }

  Widget _buildSubmitButton() {
    if (widget.editable == false) {
      return Container(
        alignment: Alignment.center,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(right: kAppbarPadding),
          ),
          child: const Text(
            'Post',
            style: kSFCaptionBold,
          ),
          onPressed: () async {
            setState(() {
              date = DateTime.now();
            });

            final createdTestimony = Testimony(
              userId: 'userId',
              title: title,
              testimony: testimony,
              date: date,
              cardColor: colorToHex(color: cardColor),
            );

            try {
              await CloudFireStore()
                  .createTestimony(testimony: createdTestimony);
            } on FirebaseException catch (e) {
              debugPrint(e.toString() + 'davies');
            }
          },
        ),
      );
    } else {
      return Row(
        children: [
          Container(
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
          ),
          Container(
            alignment: Alignment.center,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(right: kAppbarPadding),
              ),
              child: const Text(
                'Save',
                style: kSFCaptionBold,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      );
    }
  }

  dynamic _buildAppbar({required bool editable}) {
    return AppBar(
      title: _buildAppbarTitle(),
      backgroundColor: cardColor,
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
        _buildSubmitButton(),
      ],
    );
  }
}
