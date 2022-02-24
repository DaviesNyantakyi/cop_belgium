import 'package:cached_network_image/cached_network_image.dart';
import 'package:cop_belgium/providers/audio_provider.dart';
import 'package:cop_belgium/screens/all_screens.dart';
import 'package:cop_belgium/screens/donate_screen/donate_screen.dart';
import 'package:cop_belgium/screens/fasting_screen/create_fasting_screen.dart';
import 'package:cop_belgium/screens/request_baptism/request_baptism.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/providers/image_selector_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          title: 'Request baptism',
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const RequestBatismScreen(),
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
        _buildTile(
          title: 'Logout',
          onTap: () async {
            await FirebaseAuth.instance.signOut();
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
    final user = FirebaseAuth.instance.currentUser!;

    if (user.photoURL != null) {
      return CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(user.photoURL!),
        radius: 30,
        backgroundColor: kBlack,
      );
    }
    return const CircleAvatar(
      radius: 30,
      backgroundColor: kBlack,
      child: Icon(
        Icons.person_outline_outlined,
        color: Colors.white,
      ),
    );
  }

  Widget _buildAccountInfo() {
    final user = FirebaseAuth.instance.currentUser;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          user?.displayName ?? '',
          style: kSFHeadLine3,
        ),
        Text(
          user?.email ?? '',
          style: kSFBody,
        ),
      ],
    );
  }

  Widget _buildProfileTile() {
    return Consumer2<AudioProvider, ImagePickerProvider>(
      builder: (context, audioProvider, imageSelector, _) {
        return TextButton(
          style: kTextButtonStyle.copyWith(
            overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
          ),
          onPressed: () async {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider<AudioProvider>.value(
                      value: audioProvider,
                    ),
                    ChangeNotifierProvider<ImagePickerProvider>.value(
                      value: imageSelector,
                    ),
                  ],
                  child: const ProfileScreens(),
                ),
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
      },
    );
  }
}
