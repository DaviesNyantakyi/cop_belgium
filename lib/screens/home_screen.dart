import 'package:cop_belgium/screens/fasting_screen.dart';
import 'package:cop_belgium/screens/podcast_screen.dart';
import 'package:cop_belgium/screens/profile_screen.dart';
import 'package:cop_belgium/screens/testimonies_screen.dart';
import 'package:cop_belgium/utilities/colors.dart';
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
      appBar: _selectedIndex == 0 ? _buildAppbar() : null,
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
        icon: Image.asset(
          'assets/images/icons/home_icon.png',
          color: _bottomNavColor,
        ),
        label: 'Home',
        activeIcon: Image.asset(
          'assets/images/icons/home_icon.png',
          color: kBlueDark,
        ),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          'assets/images/icons/testimony_icon.png',
          color: _bottomNavColor,
        ),
        label: 'Testimonies',
        activeIcon: Image.asset(
          'assets/images/icons/testimony_icon.png',
          color: kBlueDark,
        ),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          'assets/images/icons/fasting_icon.png',
          color: _bottomNavColor,
        ),
        label: 'Fasting',
        activeIcon: Image.asset(
          'assets/images/icons/fasting_icon.png',
          color: kBlueDark,
        ),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          'assets/images/icons/profile_icon.png',
          color: _bottomNavColor,
        ),
        label: 'Profile',
        activeIcon: Image.asset(
          'assets/images/icons/profile_icon.png',
          color: kBlueDark,
        ),
      ),
    ],
  );
}

PreferredSizeWidget _buildAppbar({VoidCallback? onTap}) {
  return AppBar(
    actions: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
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
}
