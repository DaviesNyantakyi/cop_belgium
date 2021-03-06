import 'package:cop_belgium/models/testimony_model.dart';

import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/textfield.dart';

import 'package:flutter/material.dart';

class CreateTestimonyScreen extends StatefulWidget {
  // enabled edit mode

  final TestimonyModel? testimonyInfo;

  const CreateTestimonyScreen({
    Key? key,
    this.testimonyInfo,
  }) : super(key: key);

  @override
  State<CreateTestimonyScreen> createState() => _CreateTestimonyScreenState();
}

class _CreateTestimonyScreenState extends State<CreateTestimonyScreen> {
  TextEditingController titleCntlr = TextEditingController();
  TextEditingController descriptionCntrl = TextEditingController();

  @override
  void dispose() {
    titleCntlr.dispose();
    descriptionCntrl.dispose();
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
              _buildTileField(),
              _buildDescriptionField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTileField() {
    return MyTextFormField(
      controller: titleCntlr,
      hintText: 'Title',
      maxLines: null,
      keyboardType: TextInputType.multiline,
      fillColor: Colors.transparent,
    );
  }

  Widget _buildDescriptionField() {
    return MyTextFormField(
      controller: descriptionCntrl,
      hintText: 'Your testimony',
      maxLines: null,
      keyboardType: TextInputType.multiline,
      fillColor: Colors.transparent,
    );
  }

  dynamic _buildAppbar() {
    return AppBar(
      elevation: 1,
      leading: kBackButton(context: context),
      title: const Text('Create', style: kSFHeadLine3),
      actions: [
        TextButton(
          child: const Text('CREATE', style: kSFBody),
          onPressed: () async {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
