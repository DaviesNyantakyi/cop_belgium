import 'dart:io';

import 'package:cop_belgium/screens/settings_screen/about_church_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends StatefulWidget {
  static String settingsScreen = 'settingsScreen';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  PackageInfo? packageInfo;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  // Device name
  // App version

  String? deviceModel;
  String? deviceManufacturer;
  String? packageVersion;

  Future<void> sendFeedBack({required String type}) async {
    String? subject;
    String appVersion = 'App version: $packageVersion';
    String? message;

    if (type == 'bug') {
      subject = 'Bug';
      message = 'Please write about your bug here.';
    } else {
      subject = 'App Feedback';
      message = 'Please write about your feedback here.';
    }

    final Email email = Email(
      subject: subject,
      body: '''
      $message


      Device Information: 
      $deviceManufacturer - $deviceModel
      $appVersion
      ''',
      recipients: ['support@apkeroo.com'],
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (e) {
      kshowSnackbar(
        errorType: 'normal',
        context: context,
        text: e.toString(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await getAppInfo();
    await getDeviceInfo();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getAppInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    packageVersion = packageInfo?.version;
  }

  Future<void> getDeviceInfo() async {
    if (mounted) {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceModel = androidInfo.model;
        deviceManufacturer = androidInfo.manufacturer;
      } else {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceModel = iosInfo.model;
        deviceManufacturer = 'apple';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                _buildImage(),
                const SizedBox(height: 39),
                _buildAboutChruch(),
                const SizedBox(height: 5),
                const Divider(),
                _buildFeedBackTiles(),
                const SizedBox(height: 5),
                _buildPrivacyTiles(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutChruch() {
    return ListTile(
      title: const Text(
        'About Church',
        style: kSFBody,
      ),
      onTap: () async {
        await Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const AboutChruchScreen(),
          ),
        );
      },
    );
  }

  Widget _buildFeedBackTiles() {
    return Column(
      children: [
        ListTile(
          onTap: () async {
            await sendFeedBack(type: 'feedBack');
          },
          title: const Text(
            'Send Feedback',
            style: kSFBody,
          ),
        ),
        ListTile(
          onTap: () async {
            await sendFeedBack(type: 'bug');
          },
          title: const Text(
            'Report a Bug',
            style: kSFBody,
          ),
        ),
      ],
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
        Text(
          packageVersion != null ? ' v$packageVersion' : '',
          style: kSFBody,
        )
      ],
    );
  }

  Widget _buildPrivacyTiles() {
    return Column(
      children: [
        ListTile(
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
          title: const Text(
            'Terms Of Service',
            style: kSFBody,
          ),
        ),
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
