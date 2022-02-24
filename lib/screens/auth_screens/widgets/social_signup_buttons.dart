import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:flutter/material.dart';

class BuildSocialSignupButtons extends StatelessWidget {
  const BuildSocialSignupButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Buttons.buildSocialButton(
          context: context,
          icon: Image.asset(
            'assets/images/logos/google.png',
            width: kIconSize,
          ),
          label: const Text(
            'Continue with Google',
            style: kSFBtnStyleBold,
          ),
          onPressed: () {},
        ),
        const SizedBox(height: kContentSpacing12),
        Buttons.buildSocialButton(
          context: context,
          icon: Image.asset(
            'assets/images/logos/apple.png',
            width: kIconSize,
          ),
          label: const Text(
            'Continue with Apple',
            style: kSFBtnStyleBold,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
