import 'package:cop_belgium/screens/profile_screen/edit_profile_screen.dart';
import 'package:cop_belgium/screens/profile_screen/fasting_view.dart';
import 'package:cop_belgium/screens/profile_screen/saved_podcast_view.dart';
import 'package:cop_belgium/screens/profile_screen/testimonies_view.dart';
import 'package:cop_belgium/screens/settings_screen/settings_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                _buildPopupMenu(),
              ],
              bottom: TabBar(
                labelStyle: kSFSubtitle1,
                labelColor: kBlue,
                indicatorColor: kBlue,
                isScrollable: true,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                unselectedLabelColor: kBlueDark,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: kBlue, width: 2),
                ),
                controller: tabController,
                tabs: const [
                  Tab(text: 'Podcast'),
                  Tab(text: 'Testimonies'),
                  Tab(text: 'Fasting'),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: tabController,
                children: const <Widget>[
                  UserSavedPodcastView(),
                  UserTestimoniesView(),
                  UserFastingView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupMenu() {
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
      onSelected: (String result) {
        Navigator.pushNamed(context, result);
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
        ];
      },
    );
  }
}


/*
String _profileImage =
    'https://images.unsplash.com/photo-1584473457409-ae5c91d7d8b1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YmxhY2slMjBnaXJsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60';

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
      body: SafeArea(
        child: CustomScrollView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              toolbarHeight: 300,
              flexibleSpace: Column(
                children: [
                  _buildAppbar(
                    onTapBack: () {},
                    onTapEdit: () {},
                  ),
                  const SizedBox(height: 30),
                  CircleAvatar(
                    backgroundImage: NetworkImage(_profileImage),
                    radius: 60,
                    backgroundColor: kBlueDark,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Jullia Hernandez',
                    style: kSFHeadLine2,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Jullia.Hernandez@outlook.com',
                    style: kSFBody,
                  ),
                ],
              ),
              bottom: TabBar(
                labelStyle: kSFSubtitle1,
                labelColor: kBlue,
                indicatorColor: kBlue,
                isScrollable: true,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                unselectedLabelColor: kBlueDark,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: kBlue, width: 2),
                ),
                controller: tabController,
                tabs: const [
                  Tab(text: 'Podcast'),
                  Tab(text: 'Testimonies'),
                  Tab(text: 'Fasting'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

dynamic _buildAppbar({
  VoidCallback? onTapBack,
  VoidCallback? onTapEdit,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/icons/arrow_left_icon.png',
        ),
      ),
      onTap: onTapBack,
    ),
    actions: [
      Container(
        alignment: Alignment.center,
        child: InkWell(
          splashColor: kBlueLight,
          child: Padding(
            padding: const EdgeInsets.all(kAppbarPadding).copyWith(right: 20),
            child: const Text(
              'Post',
              style: kSFBody,
            ),
          ),
          onTap: onTapEdit,
        ),
      ),
    ],
  );
}*/
