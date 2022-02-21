import 'package:cop_belgium/models/testimony_model.dart';

import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/textfiel.dart';

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
  TextEditingController titleCntlr = TextEditingController();
  TextEditingController descriptionCntlr = TextEditingController();

  @override
  void initState() {
    if (widget.editable!) {
      titleCntlr.text = widget.testimonyInfo!.title!;
      descriptionCntlr.text = widget.testimonyInfo!.description!;
    }
    super.initState();
  }

  @override
  void dispose() {
    titleCntlr.dispose();
    descriptionCntlr.dispose();
    super.dispose();
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
                  hintText: 'Title',
                  style: kSFHeadLine3,
                  controller: titleCntlr,
                ),
                const SizedBox(height: 16),
                _buildTF(
                  style: kSFBody,
                  hintText: 'Your testimony',
                  controller: descriptionCntlr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTF({
    String? hintText,
    TextStyle? style,
    TextEditingController? controller,
  }) {
    return MyTextFormField(
      controller: controller,
      hintText: hintText,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      fillColor: Colors.transparent,
      style: style,
    );
  }

  Widget _buildPopupMenu({required BuildContext context}) {
    if (widget.editable == true) {
      return Row(
        children: [
          TextButton(
            style: kTextButtonStyle,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10, right: kAppbarPadding),
              child: Text('Delete', style: kSFBody.copyWith(color: kRed)),
            ),
            onPressed: () async {},
          ),
          TextButton(
            style: kTextButtonStyle,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10, right: kAppbarPadding),
              child: const Text('Save', style: kSFBody),
            ),
            onPressed: () async {},
          ),
        ],
      );
    } else {
      return TextButton(
        style: kTextButtonStyle,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 10, right: kAppbarPadding),
          child: const Text('Create', style: kSFBodyBold),
        ),
        onPressed: () async {},
      );
    }
  }

  Widget _buildTitle() {
    if (widget.editable!) {
      return const Text('Edit', style: kSFHeadLine3);
    }
    return const Text('');
  }

  dynamic _buildAppbar({required bool editable}) {
    return AppBar(
      elevation: 1,
      leading: kBackButton(context: context),
      title: _buildTitle(),
      actions: [_buildPopupMenu(context: context)],
    );
  }
}
