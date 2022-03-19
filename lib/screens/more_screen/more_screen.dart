import 'package:cached_network_image/cached_network_image.dart';
import 'package:cop_belgium/screens/churches_screen/churches_screen.dart';

import 'package:cop_belgium/utilities/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../donate_screen/donate_screen.dart';
import '../fasting_screen/fasting_screen.dart';
import '../profile_screen/profile_screen.dart';
import '../quiz_screen/quiz_screen.dart';
import '../request_baptism_screen/request_baptism.dart';
import '../settings_screen/about_church_screen.dart';
import '../settings_screen/settings_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More', style: kSFHeadLine3),
        actions: [
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: const Text(
              'LOGOUT',
              style: kSFBody,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: kBodyPadding,
          horizontal: kBodyPadding,
        ),
        child: Column(
          children: [
            _buildProfileTile(),
            const Divider(),
            _buildOtherTiles(),
          ],
        ),
      ),
    );
  }

  Widget _buildOtherTiles() {
    return Column(
      children: [
        _buildTile(
          title: 'Donate',
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const DonateScreen(),
              ),
            );
          },
        ),
        _buildTile(
          title: 'Quiz',
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const QuizScreen(),
              ),
            );
          },
        ),
        _buildTile(
          title: 'Fasting',
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const FastingScreen(),
              ),
            );
          },
        ),
        _buildTile(
          title: 'Churches',
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const ChurchesScreen(),
              ),
            );
          },
        ),
        _buildTile(
          title: 'Request Baptism',
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const RequestBatismScreen(),
              ),
            );
          },
        ),
        const Divider(),
        _buildTile(
          title: 'About Church',
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const AboutChruchScreen(),
              ),
            );
          },
        ),
        _buildTile(
          title: 'Settings',
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const SettingsScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTile({required String title, required VoidCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: kSFBodyBold,
      ),
      onTap: onTap,
    );
  }

  Widget _buildAvatar() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null && user.photoURL != null) {
      return CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(user.photoURL!),
        radius: 40,
        backgroundColor: kBlueLight,
      );
    }
    return const CircleAvatar(
      radius: 40,
      backgroundColor: kBlueLight,
      child: Icon(
        Icons.person_outline_outlined,
        color: kBlack,
      ),
    );
  }

  Widget _buildUserInfo() {
    final userName = FirebaseAuth.instance.currentUser?.displayName;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userName ?? ' ',
          style: kSFHeadLine3,
        ),
        const Text('Piwc Turnhout', style: kSFBody),
      ],
    );
  }

  Widget _buildProfileTile() {
    return TextButton(
      style: kTextButtonStyle.copyWith(
        overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
      ),
      onPressed: () async {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const ProfileScreens(),
          ),
        );
      },
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            _buildAvatar(),
            const SizedBox(width: kContentSpacing8),
            _buildUserInfo(),
          ],
        ),
      ),
    );
  }
}
