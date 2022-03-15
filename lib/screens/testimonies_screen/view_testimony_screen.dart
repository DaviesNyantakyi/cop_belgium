import 'package:cop_belgium/models/testimony_model.dart';

import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/dialog.dart';
import 'package:cop_belgium/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'edit_testimony_screen.dart';

class ViewTestimonyScreen extends StatefulWidget {
  // enabled edit mode

  final TestimonyModel testimonyInfo;

  const ViewTestimonyScreen({
    Key? key,
    required this.testimonyInfo,
  }) : super(key: key);

  @override
  State<ViewTestimonyScreen> createState() => _ViewTestimonyScreenState();
}

class _ViewTestimonyScreenState extends State<ViewTestimonyScreen> {
  TextEditingController? titleCntlr;
  TextEditingController? descriptionCntrl;

  @override
  void initState() {
    titleCntlr = TextEditingController(text: widget.testimonyInfo.title);
    descriptionCntrl = TextEditingController(
      text: widget.testimonyInfo.description,
    );
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
      readOnly: true,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      fillColor: Colors.transparent,
      style: style,
    );
  }

  dynamic _buildAppbar() {
    return AppBar(
      elevation: 1,
      leading: kBackButton(context: context),
      actions: [
        _buildDeleteButton(),
        _buildEditButton(),
      ],
    );
  }

  Widget _buildEditButton() {
    return TextButton(
      child: const Text('EDIT', style: kSFBody),
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => EditTestimonyScreen(
              testimonyInfo: widget.testimonyInfo,
            ),
          ),
        );
      },
    );
  }

  Widget _buildDeleteButton() {
    return TextButton(
      child: Text('DELETE', style: kSFBody.copyWith(color: kRed)),
      onPressed: () {
        _showDeleteDialog();
      },
    );
  }

  Future<String?> _showDeleteDialog() {
    return showMyDialog(
      context: context,
      title: const Text('Delete this Testimony?', style: kSFHeadLine3),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: kSFBody,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Delete',
            style: kSFBody.copyWith(color: kRed),
          ),
        )
      ],
    );
  }
}
