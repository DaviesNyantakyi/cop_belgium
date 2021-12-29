import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/testimony_model.dart';
import 'package:cop_belgium/services/cloud_firestore.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TestimonyCard extends StatefulWidget {
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
  State<TestimonyCard> createState() => _TestimonyCardState();
}

class _TestimonyCardState extends State<TestimonyCard> {
  bool? isLiked;

  @override
  void initState() {
    super.initState();
    checkLike();
  }

  Future<bool?> checkLike() async {
    bool hasLiked =
        await CloudFireStore().hasLikedTestimony(tInfo: widget.testimonyInfo);
    setState(() {
      isLiked = hasLiked;
    });
    return hasLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 210,
      decoration: BoxDecoration(
        color: Color(int.parse(widget.testimonyInfo.cardColor.toString()))
            .withAlpha(170),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextButton(
        onPressed: widget.onPressedCard,
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
      widget.testimonyInfo.description.toString(),
      style: kSFBody.copyWith(color: kBlueDark.withAlpha(180)),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDateCreated() {
    return Text(
      FormalDates.formatDm(date: widget.testimonyInfo.date),
      style: kSFSubtitle2.copyWith(
        color: kBlueDark.withOpacity(0.50),
      ),
    );
  }

  Widget _buildName() {
    if (widget.testimonyInfo.isAnonymous == false) {
      String? name =
          FirebaseAuth.instance.currentUser!.uid == widget.testimonyInfo.userId
              ? 'by you'
              : 'by ${widget.testimonyInfo.userName}';

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
          await CloudFireStore()
              .likeDislikeTestimony(tInfo: widget.testimonyInfo);
          await checkLike();
        } on FirebaseException catch (e) {
          debugPrint(e.toString());
          kshowSnackbar(
            context: context,
            errorType: 'normal',
            text: e.message.toString(),
          );
        }
      },
      style: kTextButtonStyle,
      child: SizedBox(
        height: 25,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLikeIcon(),
            const SizedBox(width: 7),
            _buildLikeCount(),
          ],
        ),
      ),
    );
  }

  Widget _buildLikeIcon() {
    if (isLiked != null) {
      return Image.asset(
        isLiked!
            ? 'assets/images/icons/clapping_filled.png'
            : 'assets/images/icons/clapping_outlined.png',
        filterQuality: FilterQuality.high,
        color: kBlueDark,
      );
    }
    return Image.asset(
      'assets/images/icons/clapping_outlined.png',
      filterQuality: FilterQuality.high,
      color: kBlueDark,
    );
  }

  Widget _buildLikeCount() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('Testimonies')
          .doc(widget.testimonyInfo.id)
          .collection('likers')
          .snapshots(),
      builder: (context, snapshot) {
        List? likes;
        if (snapshot.data != null) {
          likes = snapshot.data!.docs;
        }

        if (snapshot.hasData) {
          return Text('${likes!.length}', style: kSFSubtitle2);
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
            widget.testimonyInfo.title.toString(),
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
    if (widget.editable == true) {
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
          onPressed: widget.onPressedEdit,
        ),
      );
    } else {
      return Container();
    }
  }
}
