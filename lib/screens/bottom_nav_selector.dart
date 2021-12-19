import 'package:cop_belgium/screens/fasting_screen/create_fasting_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_screen.dart';
import 'package:cop_belgium/screens/profile_screen/profile_screen.dart';
import 'package:cop_belgium/screens/testimonies_screen/testimonies_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavSelectorPage extends StatefulWidget {
  static String bottomNavSelectorPage = 'bottomNavSelectorPage';
  const BottomNavSelectorPage({Key? key}) : super(key: key);

  @override
  _BottomNavSelectorPageState createState() => _BottomNavSelectorPageState();
}

class _BottomNavSelectorPageState extends State<BottomNavSelectorPage> {
  // selected bottom navigation bar item
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    PodcastScreen(),
    TestimoniesScreen(),
    CreateFastingScreens(),
    ProfileScreens(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    selectedFontSize: 0, // if not set to 0 bottom nav exception bug
    unselectedFontSize: 0, // if not set to 0 bottom nav exception bug
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
        icon: Icon(
          Icons.home_outlined,
          color: _bottomNavColor,
          size: 35,
        ),
        activeIcon: const Icon(
          Icons.home_outlined,
          color: kBlueDark,
          size: 35,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Testimonies',
        tooltip: 'Testimonies',
        icon: Icon(
          FontAwesomeIcons.clipboard,
          color: _bottomNavColor,
        ),
        activeIcon: const Icon(
          FontAwesomeIcons.clipboard,
          color: kBlueDark,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Fasting',
        tooltip: 'Fasting',
        icon: Icon(
          FontAwesomeIcons.utensils,
          color: _bottomNavColor,
        ),
        activeIcon: const Icon(
          FontAwesomeIcons.utensils,
          color: kBlueDark,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Profile',
        tooltip: 'Profile',
        icon: Icon(
          FontAwesomeIcons.user,
          color: _bottomNavColor,
        ),
        activeIcon: const Icon(
          FontAwesomeIcons.user,
          color: kBlueDark,
        ),
      ),
    ],
  );
}