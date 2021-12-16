import 'package:cop_belgium/screens/testimonies_screen/edit_testimony_screen.dart';
import 'package:cop_belgium/widgets/testimony_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

String _text =
    'Consequat magna fugiat dolor sit aliquip cupidatat sunt cillum proident. Ex adipisicing minim irure mollit. Anim minim deserunt irure est nostrud irure ullamco sit laborum id nostrud exercitation velit. Pariatur pariatur voluptate veniam ex minim ullamco. Tempor ex quis voluptate dolor ut aliqua quis ea minim. Ea mollit Lorem enim enim velit qui ea labore aute. Do aliqua ullamco duis deserunt deserunt excepteur tempor tempor eu commodo.';

String _title = 'Announcements Lorem ipsum';

class UserTestimoniesView extends StatefulWidget {
  static String userTestimoniesView = 'userTestimoniesView';

  const UserTestimoniesView({Key? key}) : super(key: key);

  @override
  State<UserTestimoniesView> createState() => _UserTestimoniesViewState();
}

class _UserTestimoniesViewState extends State<UserTestimoniesView> {
  int likes = 255;
  Color cardColor = kBlueLight;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 20,
        padding: const EdgeInsets.only(top: 20),
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kBodyPadding).copyWith(
              bottom: 10,
            ),
            child: TestimonyCard(
              editable: true,
              title: _title,
              testimony: _text,
              likes: likes,
              cardColor: cardColor,
              timeAgo: '6 Hours Ago',
              onPressedCard: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const CreateTestimonyScreen(
                    editable: true,
                  );
                }));
              },
            ),
          );
        },
      ),
    );
  }
}
