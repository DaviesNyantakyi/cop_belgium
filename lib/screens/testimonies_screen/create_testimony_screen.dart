import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/testimony_model.dart';
import 'package:cop_belgium/services/cloud_firestore.dart';
import 'package:cop_belgium/utilities/color_picker.dart';
import 'package:cop_belgium/utilities/color_to_hex.dart';

import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateTestimonyScreen extends StatefulWidget {
  static String createTestimonyScreen = 'editTestimonyScreen';

  // enabled edit mode
  final bool? editable;
  final TestimonyInfo? testimonyInfo;

  const CreateTestimonyScreen({
    Key? key,
    this.editable = false,
    this.testimonyInfo,
  }) : super(key: key);

  @override
  State<CreateTestimonyScreen> createState() => _CreateTestimonyScreenState();
}

class _CreateTestimonyScreenState extends State<CreateTestimonyScreen> {
  String? userId;
  String? title;
  String? testimony;
  DateTime? date;
  Color? cardColor = kBlueLight2;

  @override
  void initState() {
    super.initState();

    setState(() {
      if (widget.testimonyInfo != null) {
        title = widget.testimonyInfo!.title;
        testimony = widget.testimonyInfo!.testimony;
        date = widget.testimonyInfo!.date;
        cardColor = Color(
          int.parse(widget.testimonyInfo!.cardColor.toString()),
        );
      }
    });
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
                  hintText: 'Title',
                  style: kSFHeadLine1,
                  onChanged: (value) {
                    title = value;
                  },
                ),
                const SizedBox(height: 16),
                _buildTF(
                  initialValue: testimony,
                  style: kSFBody,
                  hintText: 'Testimony',
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

            final createdTestimony = TestimonyInfo(
              userId: FirebaseAuth.instance.currentUser!.uid,
              title: title,
              testimony: testimony,
              date: date,
              cardColor: cardColor!.value.toString(),
              likes: 0,
            );

            try {
              if (title != null &&
                  title!.isNotEmpty &&
                  testimony != null &&
                  testimony!.isNotEmpty) {
                await CloudFireStore()
                    .createTestimony(testimony: createdTestimony);
                Navigator.pop(context);
              } else {
                kshowSnackbar(
                  context: context,
                  child: Text(
                    'Please add title and testimony',
                    style: kSFBody.copyWith(color: Colors.black),
                  ),
                );
              }
            } on FirebaseException catch (e) {
              debugPrint(e.toString());
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
              onPressed: () async {
                var result = await _showDeleteAlert();
                if (result == 'ok') {
                  // get doc id to delete from collection

                  CloudFireStore()
                      .deleteTestimony(testimony: widget.testimonyInfo);

                  Navigator.pop(context);
                }
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
              onPressed: () async {
                final createdTestimony = TestimonyInfo(
                  userId: widget.testimonyInfo!.userId,
                  id: widget.testimonyInfo!.id,
                  title: title,
                  testimony: testimony,
                  date: widget.testimonyInfo!.date,
                  cardColor: cardColor!.value.toString(),
                );
                try {
                  if (title != null &&
                      title!.isNotEmpty &&
                      testimony != null &&
                      testimony!.isNotEmpty) {
                    await CloudFireStore()
                        .updateTestimony(testimony: createdTestimony);
                    Navigator.pop(context);
                  } else {
                    kshowSnackbar(
                      context: context,
                      child: Text(
                        'Please add title and testimony',
                        style: kSFBody.copyWith(color: Colors.black),
                      ),
                    );
                  }
                } on FirebaseException catch (e) {
                  debugPrint(e.toString());
                }
              },
            ),
          ),
        ],
      );
    }
  }

  Future<String?> _showDeleteAlert() async {
    return await showDialog<String?>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(kButtonRadius),
          ),
        ),
        title: const Text(
          'Delete this testimony?',
          style: kSFHeadLine2,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'ok'),
            child: Text(
              'Delete',
              style: kSFCaptionBold.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'cancel'),
            child: const Text('Cancel', style: kSFCaptionBold),
          ),
        ],
      ),
    );
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
