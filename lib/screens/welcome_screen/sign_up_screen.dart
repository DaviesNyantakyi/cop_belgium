import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cop_belgium/screens/home_screen.dart';
import 'package:cop_belgium/utilities/church_selector.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/checkbox.dart';
import 'package:cop_belgium/widgets/textfiel.dart';

class SignUpScreen extends StatefulWidget {
  static String signUpScreen = 'signUpScreen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? gender;
  String? selectedChurch;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20)
                .copyWith(top: kBodyPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                _buildTfFirstLastName(),
                const SizedBox(height: kTextFieldSpacing),
                MyTextField.buildTF(
                  label: 'Email',
                  hintText: 'Email',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    debugPrint(value);
                  },
                ),
                const SizedBox(height: kTextFieldSpacing),
                MyTextField.buildTF(
                  label: 'Password',
                  hintText: 'Password',
                  obscureText: true,
                  onChanged: (value) {
                    debugPrint(value);
                  },
                ),
                const SizedBox(height: kTextFieldSpacing),
                ChurchSelctor().buildChurchSelectorTile(
                  city: selectedChurch,
                  context: context,
                  onChanged: (city) {
                    setState(() {
                      selectedChurch = city;
                    });
                  },
                ),
                const SizedBox(height: kTextFieldSpacing),
                _buildGenderSelector(),
                const SizedBox(height: kButtonSpacing),
                _buildSingUpBtn(),
                const SizedBox(height: 24),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Or Continue with',
                    style: kSFBody,
                  ),
                ),
                const SizedBox(height: 24),
                _buildSocialBt()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTfFirstLastName() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SizedBox(
            width: 181,
            child: MyTextField.buildTF(
              label: 'First Name',
              hintText: 'First Name',
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                debugPrint(value);
              },
            ),
          ),
        ),
        const SizedBox(width: kTextFieldSpacing),
        Flexible(
          child: SizedBox(
            width: 181,
            child: MyTextField.buildTF(
              label: 'Last Name',
              hintText: 'Last Name',
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                debugPrint(value);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Gender',
            style: kSFBody,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyCheckBox(
              label: 'Male',
              value: 'male',
              groupsValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),
            const SizedBox(width: 10),
            MyCheckBox(
              label: 'Female',
              value: 'female',
              groupsValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      leading: Container(
        margin: const EdgeInsets.symmetric(horizontal: kAppbarPadding),
        child: TextButton(
          style: kTextButtonStyle,
          child: const Icon(
            FontAwesomeIcons.chevronLeft,
            color: kDarkBlue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      title: const Text(
        'Sing Up',
        style: kSFCaptionBold,
      ),
    );
  }

  Widget _buildSocialBt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          heroTag: 'bt1',
          elevation: 1,
          backgroundColor: kBlueLight1,
          child: Image.asset(
            'assets/images/logos/google.png',
            height: 28,
          ),
          onPressed: () async {
            await Navigator.pushReplacementNamed(
              context,
              HomeScreen.homeScreen,
            );
          },
        ),
        const SizedBox(width: 16),
        FloatingActionButton(
          heroTag: 'bt2',
          elevation: 1,
          backgroundColor: kBlueLight1,
          child: Image.asset(
            'assets/images/logos/apple.png',
            height: 28,
          ),
          onPressed: () async {
            await Navigator.pushReplacementNamed(
              context,
              HomeScreen.homeScreen,
            );
          },
        ),
      ],
    );
  }

  Widget _buildSingUpBtn() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kYellow),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(kButtonRadius),
              ),
            ),
          ),
        ),
        onPressed: () async {
          print(selectedChurch);
          /* await Navigator.pushReplacementNamed(
            context,
            HomeScreen.homeScreen,
          );*/
        },
        child: const Text(
          'Sing Up',
          style: kSFBodyBold,
        ),
      ),
    );
  }
}
