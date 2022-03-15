import 'package:cop_belgium/models/testimony_model.dart';

import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/textfield.dart';

import 'package:flutter/material.dart';

class EditTestimonyScreen extends StatefulWidget {
  // enabled edit mode

  final TestimonyModel? testimonyInfo;

  const EditTestimonyScreen({
    Key? key,
    this.testimonyInfo,
  }) : super(key: key);

  @override
  State<EditTestimonyScreen> createState() => _EditTestimonyScreenState();
}

class _EditTestimonyScreenState extends State<EditTestimonyScreen> {
  TextEditingController? titleCntlr;
  TextEditingController? descriptionCntrl;

  @override
  void initState() {
    titleCntlr = TextEditingController(text: widget.testimonyInfo?.title ?? '');
    descriptionCntrl =
        TextEditingController(text: widget.testimonyInfo?.description ?? '');
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    titleCntlr?.dispose();
    descriptionCntrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTF(
                hintText: 'Title',
                style: kSFHeadLine3,
                controller: titleCntlr,
              ),
              _buildTF(
                style: kSFBody,
                hintText: 'Your testimony',
                controller: descriptionCntrl,
              ),
            ],
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

  Widget _buildSaveButton({required BuildContext context}) {
    return TextButton(
      child: const Text('SAVE', style: kSFBodyBold),
      onPressed: () async {
        Navigator.of(context)
          ..pop()
          ..pop();
      },
    );
  }

  dynamic _buildAppbar() {
    return AppBar(
      elevation: 1,
      leading: kBackButton(context: context),
      title: const Text('Edit', style: kSFHeadLine3),
      actions: [
        _buildSaveButton(context: context),
      ],
    );
  }
}
