import 'package:cop_belgium/models/user_model.dart';
import 'package:cop_belgium/screens/profile_screen/edit_profile_screen.dart';
import 'package:cop_belgium/screens/profile_screen/fasting_history_view.dart';
import 'package:cop_belgium/screens/profile_screen/testimonies_view.dart';
import 'package:cop_belgium/screens/settings_screen/settings_screen.dart';
import 'package:cop_belgium/screens/welcome_screen/welcome_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
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
    tabController = TabController(initialIndex: 1, vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, value) {
          return [
            _buildAppbar(),
          ];
        },
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: const <Widget>[
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
        padding: const EdgeInsets.symmetric(horizontal: 25),
        unselectedLabelColor: kDarkBlue,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: kBlue, width: 2),
        ),
        tabs: const [
          Tab(text: 'Testimonies'),
          Tab(text: 'Fasting History'),
        ],
      ),
    );
  }

  Widget _buildProfilInfo({required BuildContext context}) {
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
          backgroundColor: kDarkBlue,
        ),
        const SizedBox(height: 10),
        const Text(
          'Jullia Hernandez',
          style: kSFCaptionBold,
        ),
        const Text(
          'Jullia.Hernandez@outlook.com',
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
          // logout
          await Navigator.pushReplacementNamed(
            context,
            WelcomeScreen.welcomeScreen,
          );
        } else if (result == EditProfileScreen.editProfileScreen) {
          await Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return EditProfileScreen(
                user: CopUser(
                  photo: profilePhoto,
                  firstName: 'Melisa',
                  lastName: 'Shanses',
                  email: 'MelisaShanses@outlook.com',
                  gender: 'female',
                  churchLocation: 'Turnhout',
                  isFasting: false,
                ),
              );
            },
          ));
        } else {
          await Navigator.pushNamed(context, SettingsScreen.settingsScreen);
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
