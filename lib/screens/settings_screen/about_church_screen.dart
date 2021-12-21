import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
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
                title: const Text(
                  'Abous us',
                  style: kSFBody,
                ),
                onTap: () async {
                  loadMdFile(
                    context: context,
                    mdFile: "assets/about_church/about_us.md",
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'Values',
                  style: kSFBody,
                ),
                onTap: () async {
                  loadMdFile(
                    context: context,
                    mdFile: "assets/about_church/core_values.md",
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'Mission & Vission',
                  style: kSFBody,
                ),
                onTap: () async {
                  loadMdFile(
                    context: context,
                    mdFile: "assets/about_church/mission_and_vission.md",
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'Tenets',
                  style: kSFBody,
                ),
                onTap: () async {
                  loadMdFile(
                    context: context,
                    mdFile: "assets/about_church/about_us.md",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      title: const Text('About Church', style: kSFCaptionBold),
      leading: Container(
        margin: const EdgeInsets.symmetric(horizontal: kAppbarPadding),
        child: TextButton(
          style: kTextButtonStyle,
          child: const Icon(
            FontAwesomeIcons.chevronLeft,
            color: kBlueDark,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
