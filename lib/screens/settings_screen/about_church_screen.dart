import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutChruchScreen extends StatelessWidget {
  static String aboutChruchScreen = 'aboutChruchScreen';
  const AboutChruchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/logos/cop_logo.png'),
              const SizedBox(height: 39),
              ListTile(
                onTap: () async {},
                title: const Text(
                  'Abous us',
                  style: kSFBody,
                ),
                trailing: const Icon(
                  FontAwesomeIcons.chevronRight,
                  color: kDarkBlue,
                ),
              ),
              ListTile(
                onTap: () async {},
                title: const Text(
                  'Values',
                  style: kSFBody,
                ),
                trailing: const Icon(
                  FontAwesomeIcons.chevronRight,
                  color: kDarkBlue,
                ),
              ),
              ListTile(
                onTap: () async {},
                title: const Text(
                  'Mission & Vission',
                  style: kSFBody,
                ),
                trailing: const Icon(
                  FontAwesomeIcons.chevronRight,
                  color: kDarkBlue,
                ),
              ),
              ListTile(
                onTap: () async {},
                title: const Text(
                  'Tenets',
                  style: kSFBody,
                ),
                trailing: const Icon(
                  FontAwesomeIcons.chevronRight,
                  color: kDarkBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      title: const Text('Abbout Church', style: kSFCaptionBold),
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
    );
  }
}
