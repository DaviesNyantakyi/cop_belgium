import 'package:cop_belgium/models/testimony_model.dart';
import 'package:cop_belgium/screens/testimonies_screen/create_testimony_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/testimony_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserTestimoniesView extends StatefulWidget {
  static String userTestimoniesView = 'userTestimoniesView';

  const UserTestimoniesView({Key? key}) : super(key: key);

  @override
  State<UserTestimoniesView> createState() => _UserTestimoniesViewState();
}

class _UserTestimoniesViewState extends State<UserTestimoniesView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
              horizontal: kBodyPadding, vertical: kBodyPadding)
          .copyWith(top: 20),
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: kCardSpacing),
      itemCount: 50,
      itemBuilder: (context, index) {
        return TestimonyCard(
          onPressedLike: () {},
          testimony: TestimonyInfo(
              title:
                  'Enim mollit non ipsum ipsum qui aliqua est Lorem adipisicing qui labore.',
              description:
                  'Laboris officia eu duis eu pariatur nulla cupidatat labore incididunt id amet et eiusmod irure. Ut laboris est et labore officia cupidatat veniam excepteur magna adipisicing. Qui magna nostrud labore officia duis Lorem.',
              date: DateTime.now(),
              userId: 'Davies',
              userName: 'Davies Nyantakyi',
              likes: 200),
          onPressed: () {
            _showBottomSheet(
              context: context,
              testimony: TestimonyInfo(
                title:
                    'Enim mollit non ipsum ipsum qui aliqua est Lorem adipisicing qui labore.',
                description:
                    'Laboris officia eu duis eu pariatur nulla cupidatat labore incididunt id amet et eiusmod irure. Ut laboris est et labore officia cupidatat veniam excepteur magna adipisicing. Qui magna nostrud labore officia duis Lorem.Adipisicing ullamco duis incididunt duis esse fugiat eiusmod dolor dolore ipsum magna sit et. Nulla dolor esse duis elit reprehenderit laborum eu cupidatat est labore. Aliqua ea ut ullamco enim adipisicing cillum amet officia velit id id ipsum. Enim cupidatat culpa ut dolor veniam Lorem mollit. Minim occaecat elit amet ad. Aliquip proident voluptate enim et voluptate. Sunt qui do elit occaecat reprehenderit sunt veniam qui velit proident.',
                date: DateTime.now(),
                userId: 'Davies',
                userName: 'Davies Nyantakyi',
                likes: 200,
              ),
            );
          },
          onLongPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => CreateTestimonyScreen(
                  editable: true,
                  testimonyInfo: TestimonyInfo(
                    title:
                        'Enim mollit non ipsum ipsum qui aliqua est Lorem adipisicing qui labore.',
                    description:
                        'Laboris officia eu duis eu pariatur nulla cupidatat labore incididunt id amet et eiusmod irure. Ut laboris est et labore officia cupidatat veniam excepteur magna adipisicing. Qui magna nostrud labore officia duis Lorem.Adipisicing ullamco duis incididunt duis esse fugiat eiusmod dolor dolore ipsum magna sit et. Nulla dolor esse duis elit reprehenderit laborum eu cupidatat est labore. Aliqua ea ut ullamco enim adipisicing cillum amet officia velit id id ipsum. Enim cupidatat culpa ut dolor veniam Lorem mollit. Minim occaecat elit amet ad. Aliquip proident voluptate enim et voluptate. Sunt qui do elit occaecat reprehenderit sunt veniam qui velit proident.',
                    date: DateTime.now(),
                    userId: 'Davies',
                    userName: 'Davies Nyantakyi',
                    likes: 200,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showBottomSheet({
    required BuildContext context,
    required TestimonyInfo testimony,
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

    return showBottomSheet1(
      context: context,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                testimony.title ?? '',
                style: kSFHeadLine3,
              ),
            ),
            const SizedBox(height: kTextFieldSpacing),
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
                testimony.description ?? '',
                style: kSFBody,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
