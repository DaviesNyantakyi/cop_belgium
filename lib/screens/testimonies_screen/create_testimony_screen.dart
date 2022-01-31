import 'package:cop_belgium/models/testimony_model.dart';

import 'package:cop_belgium/utilities/constant.dart';

import 'package:flutter/material.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  initialValue: 'title',
                  hintText: 'Title',
                  style: kSFHeadLine1,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                _buildTF(
                  initialValue: 'testimony',
                  style: kSFBodyBold,
                  hintText: 'Testimony',
                  onChanged: (value) {},
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
      cursorColor: kBlack,
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
        style: kSFBodyBold,
      );
    } else {
      return const Text(
        'Edit',
        style: kSFBodyBold,
      );
    }
  }

  // Future<String?> _showDeleteAlert() async {
  //   return await showDialog<String?>(
  //     barrierDismissible: true,
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(
  //           Radius.circular(kButtonRadius),
  //         ),
  //       ),
  //       title: const Text(
  //         'Delete this testimony?',
  //         style: kSFBodyBold,
  //       ),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, 'cancel'),
  //           child: const Text('Cancel', style: kSFBody),
  //         ),
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, 'ok'),
  //           child: Text('Delete', style: kSFBodyBold.copyWith(color: kRed)),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
          Icons.more_vert_outlined,
          size: 20,
        ),
        onSelected: (String result) async {},
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'save',
              child: Text(
                'Save',
                style: kSFBody,
              ),
            ),
            PopupMenuItem<String>(
              value: 'delete',
              child: Text(
                'Delete',
                style: kSFBody.copyWith(color: kRed),
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
          child: const Text('Post', style: kSFBodyBold),
        ),
        onPressed: () async {},
      );
    }
  }

  dynamic _buildAppbar({required bool editable}) {
    return AppBar(
      elevation: 1,
      title: _buildAppbarTitle(),
      leading: TextButton(
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.chevron_left_outlined,
            color: kBlack,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        Container(
          alignment: Alignment.center,
          child: const Text('Announymous', style: kSFBodyBold),
        ),
        _buildPopupMenu(context: context),
      ],
    );
  }
}
