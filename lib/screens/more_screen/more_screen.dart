import 'package:cached_network_image/cached_network_image.dart';
import 'package:cop_belgium/screens/all_screens.dart';
import 'package:cop_belgium/screens/fasting_screen/create_fasting_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: kBodyPadding,
          horizontal: kBodyPadding,
        ),
        child: Column(
          children: [
            _buildProfileTile(),
            const Divider(),
            _buildTile(
              title: 'Fasting',
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const CreateFastingScreens(),
                  ),
                );
              },
            ),
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
        ),
      ),
    );
  }

  Widget _buildTile({required String title, required VoidCallback onTap}) {
    return ListTile(
      title: Text(
        title,
        style: kSFBodyBold,
      ),
      onTap: onTap,
    );
  }

  Widget _buildAvatar() {
    final user = FirebaseAuth.instance.currentUser!;

    if (user.photoURL != null) {
      return CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(user.photoURL!),
        radius: 35,
        backgroundColor: kBlueDark,
      );
    }
    return const CircleAvatar(
      radius: 35,
      backgroundColor: kBlueDark,
      child: Icon(
        FontAwesomeIcons.userAlt,
        color: Colors.white,
      ),
    );
  }

  Widget _buildAccountInfo() {
    final user = FirebaseAuth.instance.currentUser;
    //TODO: Display name does not show when user registers

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          user?.displayName ?? '',
          style: kSFHeadLine2,
        ),
        Text(
          user?.email ?? '',
          style: kSFBody,
        ),
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
            const SizedBox(width: 15),
            _buildAccountInfo(),
          ],
        ),
      ),
    );
  }
}
