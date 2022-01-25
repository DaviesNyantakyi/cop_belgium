import 'package:cop_belgium/screens/events_screen/events_screen.dart';
import 'package:cop_belgium/screens/more_screen/more_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_screen.dart';
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
    EventsScreen(),
    TestimoniesScreen(),
    MoreScreen()
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
      color: kBlue,
    ),
    currentIndex: index,
    type: BottomNavigationBarType.fixed,
    onTap: onTap,
    items: [
      _buildBottomNavItem(
        label: 'Podcasts',
        icon: FontAwesomeIcons.headphones,
      ),
      _buildBottomNavItem(
        label: 'Events',
        icon: FontAwesomeIcons.calendar,
      ),
      _buildBottomNavItem(
        label: 'Testimonies',
        icon: FontAwesomeIcons.quoteRight,
      ),
      _buildBottomNavItem(
        label: 'More',
        icon: FontAwesomeIcons.bars,
      ),
    ],
  );
}

BottomNavigationBarItem _buildBottomNavItem({
  required String label,
  required IconData icon,
}) {
  final Color _bottomNavColor = Colors.blueGrey.shade300;

  return BottomNavigationBarItem(
    label: label,
    tooltip: label,
    icon: Icon(
      icon,
      color: _bottomNavColor,
    ),
    activeIcon: Icon(
      icon,
      color: kBlueDark,
    ),
  );
}
