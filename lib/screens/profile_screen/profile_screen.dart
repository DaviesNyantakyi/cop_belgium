import 'package:cop_belgium/screens/profile_screen/edit_profile_screen.dart';
import 'package:cop_belgium/screens/profile_screen/fasting_history_view.dart';
import 'package:cop_belgium/screens/profile_screen/saved_podcast_view.dart';
import 'package:cop_belgium/screens/profile_screen/testimonies_view.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/providers/image_selector_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              leading: kBackButton(context: context),
              elevation: 1,
              snap: true,
              floating: true,
              title: const Text('Profile', style: kSFHeadLine3),
              actions: [
                _buildActions(context: context),
              ],
            ),
          ];
        },
        body: Column(
          children: <Widget>[
            TabBar(
              controller: tabController,
              labelStyle: kSFBodyBold,
              labelColor: kBlue,
              enableFeedback: true,
              isScrollable: true,
              indicatorColor: kBlack,
              unselectedLabelColor: kBlack,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(color: kBlue, width: 2),
              ),
              padding: const EdgeInsets.only(top: 30),
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
                  SavedPodcastView(),
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

  Widget _buildActions({required BuildContext context}) {
    return Consumer<ImagePickerProvider>(
      builder: (context, imageProvider, _) {
        return TextButton(
          style: kTextButtonStyle,
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 10, right: kAppbarPadding),
            child: const Text('Edit profile', style: kSFBody),
          ),
          onPressed: () async {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider<ImagePickerProvider>.value(
                      value: imageProvider,
                    ),
                  ],
                  child: const EditProfileScreen(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
