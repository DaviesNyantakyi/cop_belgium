import 'package:cop_belgium/screens/testimonies_screen/create_testimony_screen.dart';
import 'package:cop_belgium/screens/testimonies_screen/edit_testimonies_view.dart';
import 'package:cop_belgium/screens/testimonies_screen/all_testimonies_tab_view.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    _tabController = TabController(vsync: this, length: 2, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(controller: _tabController),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: const [
            TestimoniesTabView(),
            EditTestimoniesView(),
          ],
        ),
      ),
      floatingActionButton: _builFloActionBtn(),
    );
  }

  Widget _builFloActionBtn() {
    return FloatingActionButton(
      tooltip: 'Create testimony',
      child: const Icon(Icons.add_outlined),
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
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
            indicatorColor: kBlue,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: kSFBodyBold,
            labelColor: kBlack,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(color: kBlack, width: 2),
            ),
            isScrollable: true,
            controller: controller,
            unselectedLabelColor: kBlack,
            onTap: (index) {
              setState(() {});
            },
            tabs: const [
              Tab(
                text: 'Testimonies',
              ),
              Tab(
                text: 'My Testimonies',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
