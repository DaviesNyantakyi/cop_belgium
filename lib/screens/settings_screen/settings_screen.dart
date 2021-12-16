import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<String> languages = ['English', 'Dutch'];

String text = '''Terms & Conditions
By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages or make derivative versions. The app itself, and all the trademarks, copyright, database rights, and other intellectual property rights related to it, still belong to Apkeroo.

Apkeroo is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.

The Cop Belgium app stores and processes personal data that you have provided to us, to provide our Service. It’s your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the Cop Belgium app won’t work properly or at all.

The app does use third-party services that declare their Terms and Conditions.

Link to Terms and Conditions of third-party service providers used by the app''';

class SettingsScreen extends StatefulWidget {
  static String settingsScreen = 'settingsScreen';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationOn = false;
  String? language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              _buildImage(),
              const SizedBox(height: 39),
              Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.solidBell,
                      color: kDarkBlue,
                    ),
                    title: const Text(
                      'Notifications',
                      style: kSFBody,
                    ),
                    trailing: Transform.scale(
                      scale: 0.9,
                      child: CupertinoSwitch(
                        value: notificationOn,
                        onChanged: (bool value) {
                          setState(() {
                            notificationOn = value;
                          });
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      language = await _showLanguagelectorBottomSheet(
                          context: context);
                      setState(() {});
                    },
                    leading: const Icon(
                      FontAwesomeIcons.globeAfrica,
                      color: kDarkBlue,
                    ),
                    title: const Text(
                      'Language',
                      style: kSFBody,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$language',
                          style: kSFBody,
                        ),
                        const SizedBox(width: 11),
                        const Icon(
                          FontAwesomeIcons.chevronRight,
                          color: kDarkBlue,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      FontAwesomeIcons.solidQuestionCircle,
                      color: kDarkBlue,
                    ),
                    title: const Text(
                      'About Church',
                      style: kSFBody,
                    ),
                    trailing: const Icon(
                      FontAwesomeIcons.chevronRight,
                      color: kDarkBlue,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(),
                  const SizedBox(height: 5),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      FontAwesomeIcons.headset,
                      color: kDarkBlue,
                    ),
                    title: const Text(
                      'Help & Support',
                      style: kSFBody,
                    ),
                    trailing: const Icon(
                      FontAwesomeIcons.chevronRight,
                      color: kDarkBlue,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      FontAwesomeIcons.lock,
                      color: kDarkBlue,
                    ),
                    title: const Text(
                      'Privacy Policy',
                      style: kSFBody,
                    ),
                    trailing: const Icon(
                      FontAwesomeIcons.chevronRight,
                      color: kDarkBlue,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      _showPrivacyBottomSheet();
                    },
                    leading: const Icon(
                      FontAwesomeIcons.solidFileAlt,
                      color: kDarkBlue,
                    ),
                    title: const Text(
                      'Terms Of Service',
                      style: kSFBody,
                    ),
                    trailing: const Icon(
                      FontAwesomeIcons.chevronRight,
                      color: kDarkBlue,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> _showLanguagelectorBottomSheet(
      {required BuildContext context}) async {
    return await showModalBottomSheet<String?>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: kBottomSheetHeight,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: languages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    languages[index],
                    style: kSFBody,
                  ),
                  onTap: () {
                    Navigator.pop(context, languages[index]);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<String?> _showPrivacyBottomSheet() async {
    return await showModalBottomSheet<String?>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: kBottomSheetHeight,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kBodyPadding),
                child: Text(
                  text,
                  style: kSFBody,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/logos/cop_logo.png'),
        const SizedBox(height: 10),
        const Text('v0.02', style: kSFBody)
      ],
    );
  }

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      title: const Text('Settings', style: kSFCaption),
      centerTitle: true,
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
