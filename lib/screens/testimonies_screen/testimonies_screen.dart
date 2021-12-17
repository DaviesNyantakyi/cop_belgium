import 'package:cop_belgium/screens/testimonies_screen/create_testimony_screen.dart';
import 'package:cop_belgium/screens/testimonies_screen/my_testimonies_view.dart';
import 'package:cop_belgium/screens/testimonies_screen/all_testimonies_view.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TestimoniesScreen extends StatefulWidget {
  static String testimoniesScreen = 'testimoniesScreen';
  const TestimoniesScreen({Key? key}) : super(key: key);

  @override
  State<TestimoniesScreen> createState() => _TestimoniesScreenState();
}

class _TestimoniesScreenState extends State<TestimoniesScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(controller: _tabController),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: const [
            TestimoniesView(),
            MyTestimoniesView(),
          ],
        ),
      ),
      floatingActionButton: _builFloActionBtn(),
    );
  }

  Widget _builFloActionBtn() {
    return FloatingActionButton(
      tooltip: 'Testify',
      child: const Icon(FontAwesomeIcons.plus),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const CreateTestimonyScreen();
            },
          ),
        );
      },
    );
  }

  dynamic _buildAppbar({TabController? controller}) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            physics: const BouncingScrollPhysics(),
            indicatorColor: kBlue,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(color: kBlue, width: 2),
            ),
            labelStyle: kSFCaptionBold,
            labelColor: kBlue,
            isScrollable: true,
            controller: controller,
            unselectedLabelColor: kBlueDark,
            tabs: const [
              Tab(text: 'Tesimonies'),
              Tab(text: 'My Tesimonies'),
            ],
          ),
        ),
      ),
    );
  }
}
