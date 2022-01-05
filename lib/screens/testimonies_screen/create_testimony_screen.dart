import 'package:cop_belgium/models/testimony_model.dart';
import 'package:cop_belgium/services/cloud_firestore.dart';

import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

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
  String? title;
  String? testimony;
  DateTime? date;
  Color backgroundColor = kGreyLight;
  bool isAnon = false;

  @override
  void initState() {
    super.initState();

    intitTestimonyInfo();
  }

  void intitTestimonyInfo() {
    setState(() {
      if (widget.testimonyInfo != null) {
        title = widget.testimonyInfo!.title;
        testimony = widget.testimonyInfo!.description;
        date = widget.testimonyInfo!.date;
        isAnon = widget.testimonyInfo!.isAnonymous;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
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
        'Create',
        style: kSFCaptionBold,
      );
    } else {
      return const Text(
        'Edit',
        style: kSFCaptionBold,
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
          style: kSFBodyBold,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'cancel'),
            child: const Text('Cancel', style: kSFBody),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'ok'),
            child: Text('Delete', style: kSFBodyBold.copyWith(color: kRed)),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupMenu({required BuildContext context}) {
    if (widget.editable == true) {
      return PopupMenuButton<String>(
        tooltip: 'Save & Delete',
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        elevation: 4,
        icon: const Icon(
          FontAwesomeIcons.ellipsisV,
          size: 20,
        ),
        onSelected: (String result) async {
          if (result == 'save') {
            try {
              TestimonyInfo updatedTInfo = createTestimonyInfoObject();
              setState(() {});

              if (title != null &&
                  title!.isNotEmpty &&
                  testimony != null &&
                  testimony!.isNotEmpty) {
                await CloudFireStore().updateTestimonyInfo(tInfo: updatedTInfo);

                Navigator.pop(context);
              } else {
                kshowSnackbar(
                  errorType: 'normal',
                  context: context,
                  text: 'Please add title and testimony',
                );
              }
            } on FirebaseException catch (e) {
              kshowSnackbar(
                errorType: 'error',
                context: context,
                text: e.message!,
              );
            }
          } else {
            var result = await _showDeleteAlert();
            if (result == 'ok') {
              try {
                await CloudFireStore()
                    .deleteTestimony(testimony: widget.testimonyInfo);
                Navigator.pop(context);
              } on FirebaseException catch (e) {
                kshowSnackbar(
                  context: context,
                  errorType: 'error',
                  text: e.message.toString(),
                );
              }
            }
          }
        },
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'save',
              child: Text('Update'),
            ),
            PopupMenuItem<String>(
              value: 'delete',
              child: Text(
                'Delete',
                style: kSFBody.copyWith(color: Colors.red.shade700),
              ),
            ),
          ];
        },
      );
    } else {
      return TextButton(
        style: kTextButtonStyle,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 10, right: kAppbarPadding),
          child: const Text('Post', style: kSFCaptionBold),
        ),
        onPressed: () async {
          setState(() {
            date = DateTime.now();
          });

          final createdTestimony = TestimonyInfo(
            userId: FirebaseAuth.instance.currentUser!.uid,
            userName: FirebaseAuth.instance.currentUser!.displayName,
            title: title,
            isAnonymous: isAnon,
            description: testimony,
            date: date,
            // cardColor: cardColor!.value.toString(),
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
                errorType: 'normal',
                context: context,
                text: 'Please add title and testimony',
              );
            }
          } on FirebaseException catch (e) {
            debugPrint(e.toString());

            kshowSnackbar(
              errorType: 'error',
              context: context,
              text: e.message!,
            );
          } catch (e) {
            debugPrint(e.toString());
          }
        },
      );
    }
  }

  TestimonyInfo createTestimonyInfoObject() {
    final updatedTestimony = TestimonyInfo(
      id: widget.testimonyInfo!.id,
      userId: widget.testimonyInfo!.userId,
      isAnonymous: isAnon,
      userName: widget.testimonyInfo!.userName,
      title: title,
      description: testimony,
      date: widget.testimonyInfo!.date,
      // cardColor: cardColor!.value.toString(),
      likes: widget.testimonyInfo!.likes,
    );
    return updatedTestimony;
  }

  dynamic _buildAppbar({required bool editable}) {
    return AppBar(
      elevation: 1,
      title: _buildAppbarTitle(),
      backgroundColor: backgroundColor,
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
          child: const Text('Announymous', style: kSFCaptionNormal),
        ),
        Transform.scale(
          scale: 0.9,
          child: CupertinoSwitch(
            value: isAnon,
            onChanged: (bool value) {
              setState(() {
                isAnon = value;
              });
            },
          ),
        ),
        _buildPopupMenu(context: context),
      ],
    );
  }
}
