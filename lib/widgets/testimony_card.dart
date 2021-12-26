import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/testimony_model.dart';
import 'package:cop_belgium/services/cloud_firestore.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//TODO: fix overflow error title text and edit icon

class TestimonyCard extends StatelessWidget {
  final VoidCallback? onPressedCard;
  final VoidCallback? onPressedEdit;
  final TestimonyInfo testimonyInfo;

  //show the edit icon
  final bool? editable;

  const TestimonyCard({
    Key? key,
    this.editable = false,
    this.onPressedCard,
    this.onPressedEdit,
    required this.testimonyInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 210,
      decoration: BoxDecoration(
        color:
            Color(int.parse(testimonyInfo.cardColor.toString())).withAlpha(170),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextButton(
        onPressed: onPressedCard,
        style: kTextButtonStyle,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTitleAndEditIcon(),
              const SizedBox(height: 7),
              _buildName(),
              const SizedBox(height: 3),
              _buildDateCreated(),
              const SizedBox(height: 8),
              _buildTestimonyDescription(),
              const Flexible(child: SizedBox(height: 10)),
              _buildLikeButton(context: context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTestimonyDescription() {
    return Text(
      testimonyInfo.description.toString(),
      style: kSFBody.copyWith(color: kBlueDark.withAlpha(180)),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDateCreated() {
    return Text(
      FormalDates.formatDm(date: testimonyInfo.date),
      style: kSFSubtitle2.copyWith(
        color: kBlueDark.withOpacity(0.50),
      ),
    );
  }

  Widget _buildName() {
    if (testimonyInfo.isAnonymous == false) {
      String? name =
          FirebaseAuth.instance.currentUser!.uid == testimonyInfo.userId
              ? 'by you'
              : 'by ${testimonyInfo.userName}';

      return Text(
        name,
        style: kSFSubtitle2.copyWith(color: kBlueDark),
      );
    } else {
      return Container();
    }
  }

  Widget _buildLikeButton({required BuildContext context}) {
    return TextButton(
      onPressed: () async {
        try {
          await CloudFireStore().likeDislikeTestimony(tInfo: testimonyInfo);
        } on FirebaseException catch (e) {
          debugPrint(e.toString());
          kshowSnackbar(
            context: context,
            type: 'normal',
            child: Text(
              e.message.toString(),
              style: kSFBody,
            ),
          );
        }
      },
      style: kTextButtonStyle,
      child: SizedBox(
        height: 25,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/icons/hand_clap_icon.png',
              filterQuality: FilterQuality.high,
              color: kBlueDark,
            ),
            const SizedBox(width: 7),
            _buildLikeCount(),
          ],
        ),
      ),
    );
  }

  Widget _buildLikeCount() {
    final collection = FirebaseFirestore.instance.collection('Testimonies');

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: collection.doc(testimonyInfo.id).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          int likes = snapshot.data!['likes'];
          return Text('$likes', style: kSFSubtitle2);
        }
        return const Text('...', style: kSFSubtitle2);
      },
    );
  }

  Widget _buildTitleAndEditIcon() {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: Text(
            testimonyInfo.title.toString(),
            style: kSFCaptionBold.copyWith(color: kBlueDark),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(width: 10),
        ),
        Expanded(
          flex: 1,
          child: _showEditIcon(),
        )
      ],
    );
  }

  Widget _showEditIcon() {
    if (editable == true) {
      return SizedBox(
        width: 30,
        height: 40,
        child: TextButton(
          style: kTextButtonStyle,
          child: const Icon(
            FontAwesomeIcons.edit,
            size: 20,
            color: kBlueDark,
          ),
          onPressed: onPressedEdit,
        ),
      );
    } else {
      return Container();
    }
  }
}
