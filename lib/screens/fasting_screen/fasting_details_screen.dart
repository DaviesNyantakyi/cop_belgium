import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:flutter/material.dart';

class FastingDetailsScreen extends StatefulWidget {
  const FastingDetailsScreen({Key? key}) : super(key: key);

  @override
  State<FastingDetailsScreen> createState() => _FastingDetailsScreenState();
}

class _FastingDetailsScreenState extends State<FastingDetailsScreen> {
  TextEditingController noteCntlr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: kBodyPadding),
          child: TextButton(
            style: kTextButtonStyle,
            child: Text(
              'Delete',
              style: kSFBody.copyWith(color: kRed),
            ),
            onPressed: () {},
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: SafeArea(
                  child: Column(
                    children: [
                      _buildHeader(),
                      _buildDurationDetails(),
                      const SizedBox(height: kTextFieldSpacing),
                      _buildNoteField(),
                      Expanded(child: Container()),
                      _buildSaveButton(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.all(kBodyPadding),
      child: Buttons.buildButton(
        context: context,
        btnText: 'Save',
        color: kGreen,
        width: double.infinity,
        onPressed: () {},
      ),
    );
  }

  Widget _buildNoteField() {
    return MyTextField(
      controller: noteCntlr,
      fillColor: Colors.transparent,
      maxLines: null,
      hintText: 'Add a note',
      style: kSFBody,
    );
  }

  Widget _buildDurationDetails() {
    return Padding(
      padding: const EdgeInsets.all(kBodyPadding),
      child: Column(
        children: [
          _durationText(
            leading: 'Started Fasting',
            date: DateTime.now(),
          ),
          const SizedBox(height: 20),
          _durationText(
            leading: 'End',
            date: DateTime.now(),
          ),
          const SizedBox(height: 20),
          _durationText(
            leading: 'Goal (Expected)',
            date: DateTime.now().add(const Duration(hours: 10000)),
          )
        ],
      ),
    );
  }

  Widget _durationText({required String leading, required DateTime date}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leading, style: kSFBody),
        Text(
          FormalDates.formatEDmyyyyHm(date: date),
          style: kSFBody,
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(kCardContentPadding),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: kGreenGradient,
      ),
      height: 158,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nice Effort.',
            style: kSFHeadLine2.copyWith(color: kWhite),
          ),
          const SizedBox(height: kTextFieldSpacing),
          Text(
            'You completed a fast for total of 0 minutes',
            style: kSFBody.copyWith(color: kWhite),
          ),
        ],
      ),
    );
  }
}
