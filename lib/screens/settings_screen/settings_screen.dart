import 'package:cop_belgium/screens/settings_screen/about_church_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<String> languages = ['English', 'Dutch'];

class SettingsScreen extends StatefulWidget {
  static String settingsScreen = 'settingsScreen';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationOn = false;
  String? language = 'English';

  Future<void> send() async {
    final Email email = Email(
      body: '',
      subject: '',
      recipients: ['support@apkeroo.com'],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    kshowSnackbar(
      type: 'normal',
      context: context,
      child: Text(
        platformResponse,
        style: kSFBody,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                        color: kBlueDark,
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

                        language ??= language;
                        setState(() {});
                      },
                      leading: const Icon(
                        FontAwesomeIcons.globeAfrica,
                        color: kBlueDark,
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
                            color: kBlueDark,
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        FontAwesomeIcons.solidQuestionCircle,
                        color: kBlueDark,
                      ),
                      title: const Text(
                        'About Church',
                        style: kSFBody,
                      ),
                      trailing: const Icon(
                        FontAwesomeIcons.chevronRight,
                        color: kBlueDark,
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const AboutChruchScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 5),
                    ListTile(
                      onTap: () async {
                        await send();
                      },
                      leading: const Icon(
                        FontAwesomeIcons.solidEnvelope,
                        color: kBlueDark,
                      ),
                      title: const Text(
                        'Help & Support',
                        style: kSFBody,
                      ),
                      trailing: const Icon(
                        FontAwesomeIcons.chevronRight,
                        color: kBlueDark,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        FontAwesomeIcons.lock,
                        color: kBlueDark,
                      ),
                      title: const Text(
                        'Privacy Policy',
                        style: kSFBody,
                      ),
                      onTap: () {
                        loadMdFile(
                          context: context,
                          mdFile: 'assets/privacy/privacy_policy.md',
                        );
                      },
                    ),
                    ListTile(
                      onTap: () {
                        loadMdFile(
                          context: context,
                          mdFile: 'assets/privacy/terms_of_service.md',
                        );
                      },
                      leading: const Icon(
                        FontAwesomeIcons.solidFileAlt,
                        color: kBlueDark,
                      ),
                      title: const Text(
                        'Terms Of Service',
                        style: kSFBody,
                      ),
                    ),
                  ],
                )
              ],
            ),
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

  Widget _buildImage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/logos/cop_logo.png',
          height: 140,
          width: 140,
        ),
        const SizedBox(height: 15),
        const Text(
          'v0.02',
          style: kSFBodyBold,
        )
      ],
    );
  }

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      title: const Text('Settings', style: kSFCaptionBold),
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
