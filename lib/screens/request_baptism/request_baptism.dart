import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:flutter/material.dart';

class RequestBatismScreen extends StatelessWidget {
  const RequestBatismScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Baptism', style: kSFHeadLine3),
        leading: kBackButton(context: context),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    maxWidth: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: kTextFieldSpacing),
                      const MyTextField(
                        hintText: 'First & last name',
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: kTextFieldSpacing),
                      const MyTextField(
                        hintText: 'Email',
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: kTextFieldSpacing),
                      const MyTextField(
                        hintText: 'Phone nummer',
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: kTextFieldSpacing),
                      const SizedBox(
                        height: 200,
                        child: MyTextField(
                          hintText: 'Message',
                          keyboardType: TextInputType.multiline,
                          maxLines: 30,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: kBodyPadding),
                        child: SizedBox(
                          width: double.infinity,
                          child: Buttons.buildButton(
                            context: context,
                            btnText: 'Send',
                            onPressed: () {},
                          ),
                        ),
                      )
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
}
