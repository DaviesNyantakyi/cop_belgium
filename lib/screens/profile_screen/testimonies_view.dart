import 'package:cop_belgium/models/testimony_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/testimony_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../testimonies_screen/view_testimony_screen.dart';

class UserTestimoniesView extends StatefulWidget {
  static String userTestimoniesView = 'userTestimoniesView';

  const UserTestimoniesView({Key? key}) : super(key: key);

  @override
  State<UserTestimoniesView> createState() => _UserTestimoniesViewState();
}

class _UserTestimoniesViewState extends State<UserTestimoniesView> {
  List<TestimonyModel> testimonies = [
    TestimonyModel(
      id: '1',
      title:
          'Enim mollit non ipsum ipsum qui aliqua est Lorem adipisicing qui labore.',
      description:
          'Laboris officia eu duis eu pariatur nulla cupidatat labore incididunt id amet et eiusmod irure. Ut laboris est et labore officia cupidatat veniam excepteur magna adipisicing. Qui magna nostrud labore officia duis Lorem.Adipisicing ullamco duis incididunt duis esse fugiat eiusmod dolor dolore ipsum magna sit et. Nulla dolor esse duis elit reprehenderit laborum eu cupidatat est labore. Aliqua ea ut ullamco enim adipisicing cillum amet officia velit id id ipsum. Enim cupidatat culpa ut dolor veniam Lorem mollit. Minim occaecat elit amet ad. Aliquip proident voluptate enim et voluptate. Sunt qui do elit occaecat reprehenderit sunt veniam qui velit proident.',
      date: DateTime.now(),
      userId: FirebaseAuth.instance.currentUser?.uid ?? '',
      userName: 'Davies Nyantakyi',
      likes: 200,
    ),
    TestimonyModel(
      id: '2',
      title: ' test 2',
      description:
          'Laboris officia eu duis eu pariatur nulla cupidatat labore incididunt id amet et eiusmod irure. Ut laboris est et labore officia cupidatat veniam excepteur magna adipisicing. Qui magna nostrud labore officia duis Lorem.Adipisicing ullamco duis incididunt duis esse fugiat eiusmod dolor dolore ipsum magna sit et. Nulla dolor esse duis elit reprehenderit laborum eu cupidatat est labore. Aliqua ea ut ullamco enim adipisicing cillum amet officia velit id id ipsum. Enim cupidatat culpa ut dolor veniam Lorem mollit. Minim occaecat elit amet ad. Aliquip proident voluptate enim et voluptate. Sunt qui do elit occaecat reprehenderit sunt veniam qui velit proident.',
      date: DateTime.now().subtract(const Duration(days: 367)),
      userId: 'John Smith',
      userName: 'John Smith',
      likes: 10,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(kBodyPadding).copyWith(top: kBodyPadding),
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: kContentSpacing12,
      ),
      itemCount: testimonies.length,
      itemBuilder: (context, index) {
        return TestimonyCard(
          onPressedLike: () {},
          testimony: testimonies[index],
          onPressed: () {
            if (testimonies[index].userId ==
                FirebaseAuth.instance.currentUser?.uid) {
              // Show edit/delete screen if the testimony is from  the user.
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ViewTestimonyScreen(
                    testimonyInfo: testimonies[index],
                  ),
                ),
              );
            } else {
              _showBottomSheet(
                context: context,
                testimony: testimonies[index],
              );
            }
          },
        );
      },
    );
  }

  Future<void> _showBottomSheet({
    required BuildContext context,
    required TestimonyModel testimony,
  }) {
    _buildDate() {
      String time = timeago.format(testimony.date!);

      if (time.contains('years ago') || time.contains('about a year ago')) {
        time = FormalDates.formatEDmyyyyHm(date: testimony.date);
      }

      return Text(
        time,
        style: kSFBody2,
      );
    }

    return showMyBottomSheet(
      context: context,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                testimony.title,
                style: kSFHeadLine3,
              ),
            ),
            const SizedBox(height: kContentSpacing12),
            Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    testimony.userName ?? ' ',
                    style: kSFBody2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  _buildDate(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                testimony.description,
                style: kSFBody,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
