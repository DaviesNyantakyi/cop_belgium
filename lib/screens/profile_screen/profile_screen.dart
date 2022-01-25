import 'package:cached_network_image/cached_network_image.dart';
import 'package:cop_belgium/screens/auth_screens/welcome_screen.dart';
import 'package:cop_belgium/screens/profile_screen/edit_profile_screen.dart';
import 'package:cop_belgium/screens/profile_screen/fasting_history_view.dart';
import 'package:cop_belgium/screens/profile_screen/saved_podcast_view.dart';
import 'package:cop_belgium/screens/profile_screen/testimonies_view.dart';
import 'package:cop_belgium/services/cloud_firestore.dart';
import 'package:cop_belgium/services/firebase_auth.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum WhyFarther { editProfile, settings }

class ProfileScreens extends StatefulWidget {
  static String profileScreens = 'profileScreens';
  const ProfileScreens({Key? key}) : super(key: key);

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens>
    with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, vsync: this, length: 3);
  }

  Future<void> popUp(String? result) async {
    try {
      if (result == WelcomeScreen.welcomeScreen) {
        await FireAuth().singout();
        Navigator.pop(context);
      }
      if (result == EditProfileScreen.editProfileScreen) {
        final user = await CloudFireStore().getUserFirstore();

        if (user != null) {
          await Navigator.push(context, CupertinoPageRoute(
            builder: (context) {
              return EditProfileScreen(user: user);
            },
          ));
        }
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          _buildPopupMenu(context: context),
        ],
      ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: _buildProfilInfo(context: context),
            ),
          ];
        },
        body: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            TabBar(
              controller: tabController,
              labelStyle: kSFBodyBold,
              labelColor: kBlueDark,
              isScrollable: true,
              indicatorColor: kBlueDark,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              unselectedLabelColor: kBlueDark,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(color: kBlueDark, width: 2),
              ),
              tabs: const [
                Tab(text: 'Podcasts'),
                Tab(text: 'Testimonies'),
                Tab(text: 'Fasting History'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  UserSavedPodcastView(),
                  UserTestimoniesView(),
                  UserFastingHistoryView()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilInfo({required BuildContext context}) {
    final user = FirebaseAuth.instance.currentUser;
    return Column(
      children: [
        _buildAvatar(),
        const SizedBox(height: 10),
        Text(
          user?.displayName ?? '',
          style: kSFBodyBold.copyWith(fontSize: 18),
        ),
        Text(
          user?.email ?? '',
          style: kSFCaption,
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    final user = FirebaseAuth.instance.currentUser;

    if (user?.photoURL != null) {
      return CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(user!.photoURL!),
        radius: 50,
        backgroundColor: kBlueDark,
      );
    }
    return const CircleAvatar(
      radius: 50,
      backgroundColor: kBlueDark,
      child: Icon(
        FontAwesomeIcons.userAlt,
        color: Colors.white,
      ),
    );
  }

  Widget _buildPopupMenu({required BuildContext context}) {
    return PopupMenuButton<String>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      elevation: 4,
      icon: const Icon(
        FontAwesomeIcons.ellipsisV,
        size: 20,
      ),
      onSelected: popUp,
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: EditProfileScreen.editProfileScreen,
            child: const Text(
              'Edit Profile',
            ),
          ),
          PopupMenuItem<String>(
            value: WelcomeScreen.welcomeScreen,
            child: const Text(
              'Logout',
            ),
          ),
        ];
      },
    );
  }
}
