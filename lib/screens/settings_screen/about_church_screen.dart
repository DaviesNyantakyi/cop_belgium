import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';

TextStyle _textStyle = kSFBodyBold;

class AboutChruchScreen extends StatelessWidget {
  static String aboutChruchScreen = 'aboutChruchScreen';
  const AboutChruchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: kBodyPadding),
          child: Column(
            children: [
              _buildLogo(),
              const SizedBox(height: 39),
              ListTile(
                title: Text(
                  'Abous us',
                  style: _textStyle,
                ),
                onTap: () async {
                  loadMdFile(
                    context: context,
                    mdFile: "assets/about_church/about_us.md",
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Values',
                  style: _textStyle,
                ),
                onTap: () async {
                  loadMdFile(
                    context: context,
                    mdFile: "assets/about_church/core_values.md",
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Mission & Vission',
                  style: _textStyle,
                ),
                onTap: () async {
                  loadMdFile(
                    context: context,
                    mdFile: "assets/about_church/mission_and_vission.md",
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Tenets',
                  style: _textStyle,
                ),
                onTap: () async {
                  loadMdFile(
                    context: context,
                    mdFile: "assets/about_church/tenets.md",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/images/logos/cop_logo.png',
      width: kCopLogoSize,
    );
  }

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      title: const Text(
        'About Church',
        style: kSFHeadLine3,
      ),
      leading: kBackButton(context: context),
    );
  }
}
