import 'package:cop_belgium/screens/announcement_screen/announcement.dart';
import 'package:cop_belgium/screens/fasting_screen/fasting_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_screen.dart';
import 'package:cop_belgium/screens/profile_screen/profile_screen.dart';
import 'package:cop_belgium/screens/testimonies_screen/testimonies_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String homeScreen = 'HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // selected bottom navigation bar item
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    PodcastScreen(),
    TestimoniesScreen(),
    FastingScreens(),
    ProfileScreens(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(
        selectedIndex: _selectedIndex,
        onTap: () {
          Navigator.pushNamed(context, AnnouncementScreen.announcementScreen);
        },
      ),
      body: SafeArea(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: _buildBottomNavBar(
        index: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}

Widget _buildBottomNavBar({Function(int)? onTap, required int index}) {
  final Color _bottomNavColor = Colors.blueGrey.shade300;
  return BottomNavigationBar(
    backgroundColor: Colors.white,
    selectedItemColor: kBlueDark,
    unselectedItemColor: kYellow,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedFontSize: 0, // if not set to 0 exception bug
    unselectedFontSize: 0, // if not set to 0 exception bug
    selectedIconTheme: const IconThemeData(
      color: kBlueDark,
    ),
    unselectedIconTheme: const IconThemeData(
      color: kBlueLight,
    ),
    currentIndex: index,
    type: BottomNavigationBarType.fixed,
    onTap: onTap,
    items: [
      BottomNavigationBarItem(
        tooltip: 'Home',
        label: 'Home',
        icon: Image.asset(
          'assets/images/icons/home_icon.png',
          color: _bottomNavColor,
        ),
        activeIcon: Image.asset(
          'assets/images/icons/home_icon.png',
          color: kBlueDark,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Testimonies',
        tooltip: 'Testimonies',
        icon: Image.asset(
          'assets/images/icons/testimony_icon.png',
          color: _bottomNavColor,
        ),
        activeIcon: Image.asset(
          'assets/images/icons/testimony_icon.png',
          color: kBlueDark,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Fasting',
        tooltip: 'Fasting',
        icon: Image.asset(
          'assets/images/icons/fasting_icon.png',
          color: _bottomNavColor,
        ),
        activeIcon: Image.asset(
          'assets/images/icons/fasting_icon.png',
          color: kBlueDark,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Profile',
        tooltip: 'Profile',
        icon: Image.asset(
          'assets/images/icons/profile_icon.png',
          color: _bottomNavColor,
        ),
        activeIcon: Image.asset(
          'assets/images/icons/profile_icon.png',
          color: kBlueDark,
        ),
      ),
    ],
  );
}

dynamic _buildAppbar({VoidCallback? onTap, required int selectedIndex}) {
  if (selectedIndex == 0) {
    return AppBar(
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: kAppbarPadding),
          child: InkWell(
            splashColor: kBlueLight,
            child: Image.asset(
              'assets/images/icons/notification_icon.png',
            ),
            onTap: onTap,
          ),
        ),
      ],
    );
  } else {
    return null;
  }
}
