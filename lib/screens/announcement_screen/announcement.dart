import 'package:cop_belgium/screens/announcement_screen/widget/announcement_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String _title =
    'Announcements Lorem ipsumuievbiiiiiiiihvizoeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee';
String _announcement =
    '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. In placerat adipiscing nulla tempus facilisi. Semper tempor eu a, libero magnis.

Egestas amet, at sit dapibus tortor, lacus orci aliquet. Odio elit vitae sagittis ac sem aenean nisl pretium sagittis. Vitae hac dictum faucibus fringilla faucibus morbi. Sed nisl tempus est vulputate enim convallis consectetur. Convallis eget lacus, integer enim accumsan.

Mollis sed faucibus volutpat accumsan justo tempor lectus eu quis. Interdum adipiscing et quam nunc elementum volutpat eu. Diam nibh sit lobortis nisl scelerisque eu. Odio pulvinar quis vitae ut. Justo lacus vitae pretium dolor sed cursus venenatis. 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In placerat adipiscing nulla tempus facilisi. Semper tempor eu a, libero magnis.

Egestas amet, at sit dapibus tortor, lacus orci aliquet. Odio elit vitae sagittis ac sem aenean nisl pretium sagittis. Vitae hac dictum faucibus fringilla faucibus morbi. Sed nisl tempus est vulputate enim convallis consectetur. Convallis eget lacus, integer enim accumsan.

Mollis sed faucibus volutpat accumsan justo tempor lectus eu quis. Interdum adipiscing et quam nunc elementum volutpat eu. Diam nibh sit lobortis nisl scelerisque eu. Odio pulvinar quis vitae ut. Justo lacus vitae pretium dolor sed cursus venenatis.''';

class AnnouncementScreen extends StatelessWidget {
  static String announcementScreen = 'announcementScreen';
  const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kBodyPadding).copyWith(
              bottom: kBodyBottomPadding,
              top: kBodyPadding,
            ),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                // Refactor code so thzt only the method is called
                return AnnouncementCard(
                  title: _title,
                  timeAgo: '15 Min Ago',
                  announcement: _announcement,
                  onPressed: () {
                    _showBottomSheet(
                      context: context,
                      title: _title,
                      announcement: _announcement,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Announcements',
        style: kSFHeadLine2,
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

  Future<void> _showBottomSheet({
    required BuildContext context,
    required String title,
    required String announcement,
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
              _announcement,
              style: kSFBody,
            ),
          ),
        ],
      ),
    );
  }
}
