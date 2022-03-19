import 'package:cop_belgium/models/church_model.dart';
import 'package:cop_belgium/models/service_time_model.dart';
import 'package:cop_belgium/screens/churches_screen/create_church_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChurchDetailScreen extends StatelessWidget {
  final ChurchModel church;
  const ChurchDetailScreen({Key? key, required this.church}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context: context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(context: context),
              _buildChurchDetails(),
            ],
          ),
        ),
      ),
    );
  }

  dynamic _buildAppBar({required BuildContext context}) {
    return AppBar(
      leading: kBackButton(context: context),
      actions: [
        TextButton(
          child: Text('DELETE', style: kSFBody.copyWith(color: kRed)),
          onPressed: () {
            _showDeleteDialog(context: context);
          },
        ),
        TextButton(
          child: const Text('EDIT', style: kSFBody),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildChurchDetails() {
    return Padding(
      padding: const EdgeInsets.all(kBodyPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kContentSpacing8),
          _buildChurchInfo(),
          const SizedBox(height: kContentSpacing8),
          const Divider(),
          const Text('Service times', style: kSFBody),
          const SizedBox(height: kContentSpacing8),
          _buildServiceTimes(),
          const SizedBox(height: kContentSpacing32),
          const Text('Leader', style: kSFBodyBold),
          _buildProfileTile()
        ],
      ),
    );
  }

  Widget _buildServiceTimes() {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Container(
          height: kContentSpacing16,
        );
      },
      shrinkWrap: true,
      itemCount: church.serviceTime.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ServiceTimeCard(
          key: ObjectKey(church.serviceTime[index]),
          serviceTime: ServiceTimeModel(
            day: church.serviceTime[index].day,
            description: church.serviceTime[index].description,
            time: church.serviceTime[index].time,
          ),
          edit: () async {},
          delete: () {},
        );
      },
    );
  }

  Future<String?> _showDeleteDialog({required BuildContext context}) {
    return showMyDialog(
      context: context,
      title: const Text('Delete this Church?', style: kSFHeadLine3),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: kSFBody,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Delete',
            style: kSFBody.copyWith(color: kRed),
          ),
        )
      ],
    );
  }

  Widget _buildChurchInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(church.churchName, style: kSFHeadLine2),
        Text(church.city, style: kSFBody),
        const SizedBox(height: kContentSpacing8),
        Text(church.phoneNumber, style: kSFCaption),
      ],
    );
  }

  Widget _buildProfileTile() {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          _buildAvatar(),
          const SizedBox(width: kContentSpacing8),
          _buildUserInfo(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final user = FirebaseAuth.instance.currentUser;

    if (user?.photoURL != null) {
      return const CircleAvatar(
        // backgroundImage: CachedNetworkImageProvider(user.photoURL!),
        radius: 30,
        backgroundColor: kBlueLight,
      );
    }
    return const CircleAvatar(
      radius: 30,
      backgroundColor: kBlueLight,
      child: Icon(
        Icons.person_outline_outlined,
        color: kBlack,
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          church.leaderInfo['leader'],
          style: kSFHeadLine3,
        ),
        Text(church.churchName, style: kSFBody),
      ],
    );
  }

  Widget _buildImage({required BuildContext context}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      decoration: BoxDecoration(
        color: kBlueLight,
        image: church.imageURL != null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(church.imageURL!),
              )
            : null,
      ),
    );
  }
}
