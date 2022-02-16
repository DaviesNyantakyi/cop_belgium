import 'package:cop_belgium/screens/events_screen/events_screen.dart';
import 'package:cop_belgium/screens/more_screen/more_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_screen.dart';
import 'package:cop_belgium/screens/testimonies_screen/testimonies_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

class BottomNavSelectorPage extends StatefulWidget {
  static String bottomNavSelectorPage = 'bottomNavSelectorPage';
  const BottomNavSelectorPage({Key? key}) : super(key: key);

  @override
  _BottomNavSelectorPageState createState() => _BottomNavSelectorPageState();
}

class _BottomNavSelectorPageState extends State<BottomNavSelectorPage> {
  int _selectedIndex = 3;

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
          if (mounted) {
            setState(() {
              _selectedIndex = value;
            });
          }
        },
      ),
    );
  }
}

Widget _buildBottomNavBar({Function(int)? onTap, required int index}) {
  return BottomNavigationBar(
    backgroundColor: Colors.white,
    selectedItemColor: kBlue,
    unselectedItemColor: kBlack,
    selectedFontSize:
        kSFCaption.fontSize!, // if not set to 0 bottom nav exception bug
    unselectedFontSize:
        kSFCaption.fontSize!, // if not set to 0 bottom nav exception bug
    selectedLabelStyle: kSFBody2,

    currentIndex: index,
    type: BottomNavigationBarType.fixed,
    onTap: onTap,
    items: [
      _buildBottomNavItem(
        label: 'Podcasts',
        icon: Icons.podcasts_outlined,
      ),
      _buildBottomNavItem(
        label: 'Events',
        icon: Icons.calendar_today_outlined,
      ),
      _buildBottomNavItem(
        label: 'Testimonies',
        icon: Icons.format_quote_outlined,
      ),
      _buildBottomNavItem(
        label: 'More',
        icon: Icons.menu_outlined,
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
      color: kBlue,
    ),
  );
}
