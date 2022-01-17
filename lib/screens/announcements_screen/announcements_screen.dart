import 'package:cop_belgium/screens/announcements_screen/announcements_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title =
        'Labore adipisicing qui magna cillum cillum nulla excepteur ';
    String description =
        'Cillum qui laborum nulla deserunt et qui do cupidatat exercitation ut non ut consequat dolor. Ullamco pariatur in laboris Lorem culpa velit proident labore aliqua et aute in occaecat incididunt. Laboris qui fugiat nulla dolore eiusmod dolor ad dolore occaecat veniam fugiat incididunt incididunt officia.';
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SafeArea(
        child: RefreshIndicator(
          color: kBlueDark,
          onRefresh: () async {},
          child: ListView.separated(
            padding: const EdgeInsets.all(kBodyPadding),
            separatorBuilder: (context, _) => const SizedBox(height: 10),
            itemCount: 7,
            itemBuilder: (context, index) {
              return Center(
                child: AnnouncementsCard(
                  title:
                      'Labore adipisicing qui magna cillum cillum nulla excepteur ',
                  date: '25 min Ago',
                  description:
                      'Duis quis officia in ea occaecat duis cupidatat velit. Ex non laborum dolor aliqua qui tempor incididunt adipisicing dolore tempor duis ullamco exercitation. Proident ullamco deserunt deserunt laborum nisi duis mollit et labore consequat id culpa. Consectetur proident eiusmod ipsum excepteur ullamco pariatur qui sit nostrud veniam ut sint. Laboris deserunt eu qui cupidatat.',
                  onPressed: () {
                    _showBottomSheet(
                      context: context,
                      title: title,
                      description: description,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showBottomSheet({
    required BuildContext context,
    required String title,
    required String description,
  }) {
    return showMyBottomSheet(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: kSFHeadLine2,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              description,
              style: kSFBody,
            ),
          ),
        ],
      ),
    );
  }

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const Text(
        'Announcements',
        style: kSFBodyBold,
      ),
      leading: TextButton(
        child: const Icon(
          FontAwesomeIcons.chevronLeft,
          color: kBlueDark,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        style: kTextButtonStyle,
      ),
    );
  }
}
