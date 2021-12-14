import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String _text =
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
            child: Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    // Refactor code so thzt only the method is called
                    return _buildAnnoncementCard(
                      title: 'Announcements Lorem ipsum',
                      timeAgo: '15 Min Ago',
                      announcement:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eu vestibulum volutpat habitasse augue aliquam. Eget non hac nibh feugiat vestibulum nisi, consectetur viverra. ',
                      onPressed: () {
                        _showBottomSheet(
                          context: context,
                          title: 'Announcements Lorem ipsum',
                          announcement: _text,
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnnoncementCard({
    required String title,
    required String announcement,
    required String timeAgo,
    VoidCallback? onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      height: 180,
      decoration: const BoxDecoration(
        color: kBlueLight,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: kTextButtonStyle,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20)
              .copyWith(left: 20, right: 23),
          child: Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: kSFCaption,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      timeAgo,
                      style: kSFSubtitle2,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                announcement,
                style: kSFBody,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              )
            ],
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
              _text,
              style: kSFBody,
            ),
          ),
        ],
      ),
    );
  }
}
