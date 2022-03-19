import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/textfield.dart';
import 'package:flutter/material.dart';

class RequestBatismScreen extends StatefulWidget {
  const RequestBatismScreen({Key? key}) : super(key: key);

  @override
  State<RequestBatismScreen> createState() => _RequestBatismScreenState();
}

class _RequestBatismScreenState extends State<RequestBatismScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Baptism', style: kSFHeadLine3),
        leading: kBackButton(context: context),
        actions: [
          TextButton(
            child: const Text('SEND', style: kSFBody),
            onPressed: () {},
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
              child: Column(
                children: [
                  const SizedBox(height: kContentSpacing8),
                  _buildFirstNameField(),
                  const SizedBox(height: kContentSpacing8),
                  _buildEmailField(),
                  const SizedBox(height: kContentSpacing8),
                  _buildPhoneNumberField(),
                  const SizedBox(height: kContentSpacing8),
                  _buildDescriptionField(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFirstNameField() {
    return const MyTextFormField(
      hintText: 'First and last name',
      maxLines: 1,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildEmailField() {
    return const MyTextFormField(
      hintText: 'Email',
      maxLines: 1,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPhoneNumberField() {
    return const MyTextFormField(
      hintText: 'Phone nummer',
      maxLines: 1,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildDescriptionField() {
    return const MyTextFormField(
      hintText: 'Message',
      keyboardType: TextInputType.multiline,
    );
  }
}
