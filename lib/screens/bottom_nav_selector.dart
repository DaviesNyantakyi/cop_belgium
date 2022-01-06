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
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    PodcastScreen(),
    TestimoniesScreen(),
    ProfileScreens(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          children: _screens,
          index: _selectedIndex,
        ),
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
        tooltip: 'Podcasts',
        label: 'Podcasts',
        icon: Icon(
          FontAwesomeIcons.headphones,
          color: _bottomNavColor,
          size: 28,
        ),
        activeIcon: const Icon(
          FontAwesomeIcons.headphones,
          color: kBlueDark,
          size: 28,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Testimonies',
        tooltip: 'Testimonies',
        icon: Icon(
          FontAwesomeIcons.quoteRight,
          color: _bottomNavColor,
        ),
        activeIcon: const Icon(
          FontAwesomeIcons.quoteRight,
          color: kBlueDark,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Profile',
        tooltip: 'Profile',
        icon: Icon(
          FontAwesomeIcons.userAlt,
          color: _bottomNavColor,
        ),
        activeIcon: const Icon(
          FontAwesomeIcons.userAlt,
          color: kBlueDark,
        ),
      ),
    ],
  );
}
