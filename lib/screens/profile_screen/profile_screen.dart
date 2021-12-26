import 'package:cop_belgium/models/user_model.dart';
import 'package:cop_belgium/screens/auth_screens/welcome_screen.dart';
import 'package:cop_belgium/screens/profile_screen/edit_profile_screen.dart';
import 'package:cop_belgium/screens/profile_screen/fasting_history_view.dart';
import 'package:cop_belgium/screens/profile_screen/saved_podcast_view.dart';
import 'package:cop_belgium/screens/profile_screen/testimonies_view.dart';
import 'package:cop_belgium/screens/settings_screen/settings_screen.dart';
import 'package:cop_belgium/services/firebase_auth.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String profilePhoto =
    'https://images.unsplash.com/photo-1584473457409-ae5c91d7d8b1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YmxhY2slMjBnaXJsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, value) {
          return [
            _buildAppbar(),
          ];
        },
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          controller: tabController,
          children: const <Widget>[
            UserSavedPodcastView(),
            UserTestimoniesView(),
            UserFastingHistoryView()
          ],
        ),
      ),
    );
  }

  Widget _buildAppbar() {
    return SliverAppBar(
      toolbarHeight: 190,
      floating: true,
      forceElevated: true,
      elevation: 5,
      flexibleSpace: _buildProfilInfo(context: context),
      bottom: TabBar(
        controller: tabController,
        labelStyle: kSFSubtitle1,
        labelColor: kBlue,
        indicatorColor: kBlue,
        isScrollable: true,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        unselectedLabelColor: kBlueDark,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: kBlue, width: 2),
        ),
        tabs: const [
          Tab(text: 'Podcast'),
          Tab(text: 'Testimonies'),
          Tab(text: 'Fasting History'),
        ],
      ),
    );
  }

  Widget _buildProfilInfo({required BuildContext context}) {
    final user = FirebaseAuth.instance.currentUser!;
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            _buildPopupMenu(context: context),
          ],
        ),
        CircleAvatar(
          backgroundImage: NetworkImage(profilePhoto),
          radius: 40,
          backgroundColor: kBlueDark,
        ),
        const SizedBox(height: 10),
        Text(
          user.displayName ?? ' ',
          style: kSFCaptionBold,
        ),
        Text(
          user.email ?? ' ',
          style: kSFSubtitle2,
        ),
      ],
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
      onSelected: (String result) async {
        if (result == WelcomeScreen.welcomeScreen) {
          await Authentication().singout();
        } else if (result == EditProfileScreen.editProfileScreen) {
          await Navigator.push(context, CupertinoPageRoute(
            builder: (context) {
              return EditProfileScreen(
                user: CopUser(
                  title: 'user',
                  photoUrl: profilePhoto,
                  firstName: 'Melisa',
                  lastName: 'Shanses',
                  isOnline: true,
                  email: 'MelisaShanses@outlook.com',
                  gender: 'female',
                  church: 'Turnhout',
                  isFasting: false,
                  isAdmin: false,
                ),
              );
            },
          ));
        } else {
          await Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const SettingsScreen(),
            ),
          );
        }
      },
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: EditProfileScreen.editProfileScreen,
            child: const Text('Edit Profile'),
          ),
          PopupMenuItem<String>(
            value: SettingsScreen.settingsScreen,
            child: const Text('Settings'),
          ),
          PopupMenuItem<String>(
            value: WelcomeScreen.welcomeScreen,
            child: const Text('Logout'),
          ),
        ];
      },
    );
  }
}
