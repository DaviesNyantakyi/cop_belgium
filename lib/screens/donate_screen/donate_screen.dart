import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:flutter/material.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _builAppBar(context: context),
      body: LayoutBuilder(
        // use layout builder to get screen size
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
            child: ConstrainedBox(
              // Set the maxium with and height
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                // Use IntrinsicHeight  to size the expandible widget to a more reasonable height.
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  const SizedBox(height: 50),
                  Image.asset('assets/images/donate.png', height: 150),
                  const SizedBox(height: 50),
                  _buildText(),
                  Expanded(child: Container(height: 90)),
                  Padding(
                    padding: const EdgeInsets.all(kBodyPadding),
                    child: Buttons.buildBtn(
                      width: double.infinity,
                      context: context,
                      btnText: 'Continue',
                      onPressed: () {},
                    ),
                  )
                ]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildText() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: const [
            Icon(
              Icons.exit_to_app_outlined,
              size: 32,
            ),
            SizedBox(width: 20),
            Flexible(
              child: Text(
                'You are about to leave the app to go to an external donation serivce.',
                style: kSFBody,
              ),
            ),
          ],
        ),
        const SizedBox(height: kBodyPadding),
        Row(
          children: const [
            Icon(
              Icons.no_encryption_outlined,
              size: 32,
            ),
            SizedBox(width: 20),
            Flexible(
              child: Text(
                'This donation service does not unlock any additional content within this app.',
                style: kSFBody,
              ),
            ),
          ],
        ),
      ],
    );
  }

  PreferredSizeWidget _builAppBar({required BuildContext context}) {
    return AppBar(
      leading: kBackButton(context: context),
      title: const Text('Donate', style: kSFHeadLine3),
    );
  }
}
