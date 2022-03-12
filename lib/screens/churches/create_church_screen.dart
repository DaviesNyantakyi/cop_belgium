import 'dart:io';

import 'package:cop_belgium/providers/image_picker_provider.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/textfield.dart';
import 'package:flutter/material.dart';

class CreateChurchScreen extends StatefulWidget {
  const CreateChurchScreen({Key? key}) : super(key: key);

  @override
  State<CreateChurchScreen> createState() => _CreateChurchScreenState();
}

class _CreateChurchScreenState extends State<CreateChurchScreen> {
  late ImagePickerProvider imagePickerProvider = ImagePickerProvider();
  final TextEditingController churchNameCntlr = TextEditingController();
  final TextEditingController streetCntlr = TextEditingController();
  final TextEditingController streetNumberCntlr = TextEditingController();
  final TextEditingController cityCntlr = TextEditingController();
  final TextEditingController postcode = TextEditingController();
  final TextEditingController provinceCntlr = TextEditingController();
  final TextEditingController phoneNumberCntlr = TextEditingController();
  final TextEditingController emailCntrl = TextEditingController();

  final churchNameKey = GlobalKey<FormState>();
  final streetKey = GlobalKey<FormState>();
  final streetNumberKey = GlobalKey<FormState>();
  final cityKey = GlobalKey<FormState>();
  final postcodeKey = GlobalKey<FormState>();
  final provinceKey = GlobalKey<FormState>();
  final phoneNumberKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();

  File? churchImage;
  File? leaderImage;

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    churchNameCntlr.dispose();
    streetCntlr.dispose();
    streetNumberCntlr.dispose();
    cityCntlr.dispose();
    postcode.dispose();
    provinceCntlr.dispose();
    phoneNumberCntlr.dispose();
    emailCntrl.dispose();

    churchNameKey.currentState?.dispose();
    streetKey.currentState?.dispose();
    streetNumberKey.currentState?.dispose();
    cityKey.currentState?.dispose();
    postcodeKey.currentState?.dispose();
    provinceKey.currentState?.dispose();
    phoneNumberKey.currentState?.dispose();
    emailKey.currentState?.dispose();

    imagePickerProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create', style: kSFHeadLine3),
        leading: kBackButton(context: context),
        actions: [
          TextButton(
            child: const Text(
              'CREATE',
              style: kSFBody,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildImage(),
              Padding(
                padding: const EdgeInsets.all(kBodyPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildChurchTextField(),
                    _buildStreetAndNumberTextField(),
                    _buildCityAndPostCodeTextField(),
                    _buildProvinceTextField(),
                    _buildContactEmailTextField(),
                    _buildPhoneNumberTextField(),
                    const SizedBox(height: kContentSpacing12),
                    _buildLeaderTile(),
                    const Divider(),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Text(index.toString());
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (churchImage != null) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.30,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.file(
              churchImage!,
            ).image,
          ),
          color: kGrey,
        ),
        child: TextButton(
          onPressed: () async {},
          style: kTextButtonStyle,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(kButtonRadius),
            ),
            child: Container(),
          ),
        ),
      );
    }

    return Container(
      height: 260,
      decoration: const BoxDecoration(
        color: kGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(kCardRadius),
        ),
      ),
      child: TextButton(
        onPressed: () async {},
        style: kTextButtonStyle,
        child: const Center(
          child: Icon(
            Icons.collections_outlined,
            color: kBlack,
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderTile() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kBodyPadding),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Leader', style: kSFBody),
          const SizedBox(height: kContentSpacing12),
          Row(
            children: [
              _buildAvatar(),
              const SizedBox(width: kContentSpacing8),
              const Expanded(
                child: MyTextFormField(
                  fillColor: Colors.transparent,
                  hintText: 'Leader',
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    if (leaderImage != null && churchImage?.path != null) {
      return CircleAvatar(
        backgroundImage: Image.file(leaderImage!).image,
        radius: 30,
        backgroundColor: kBlueLight,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          child: TextButton(
            child: Container(),
            onPressed: () async {},
          ),
        ),
      );
    }
    return CircleAvatar(
      radius: 30,
      backgroundColor: kBlueLight,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        child: TextButton(
          onPressed: () async {
            await imagePickerProvider.showBottomSheet(context: context);
          },
          style: kTextButtonStyle,
          child: const Center(
            child: Icon(Icons.person_outline_outlined, color: kBlack),
          ),
        ),
      ),
    );
  }

  Widget _buildStreetAndNumberTextField() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: _buildStreetTextField(),
        ),
        Expanded(
          flex: 2,
          child: _buildStreetNumberTextField(),
        ),
      ],
    );
  }

  Widget _buildCityAndPostCodeTextField() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: _buildCityTextField(),
        ),
        Expanded(
          flex: 2,
          child: _buildPostcodeTextField(),
        ),
      ],
    );
  }

  Widget _buildChurchTextField() {
    return Form(
      key: churchNameKey,
      child: MyTextFormField(
        controller: churchNameCntlr,
        maxLines: 1,
        fillColor: Colors.transparent,
        hintText: 'Church name',
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _buildProvinceTextField() {
    return Form(
      key: provinceKey,
      child: MyTextFormField(
        controller: provinceCntlr,
        maxLines: 1,
        fillColor: Colors.transparent,
        hintText: 'Province',
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _buildContactEmailTextField() {
    return Form(
      key: emailKey,
      child: MyTextFormField(
        controller: emailCntrl,
        maxLines: 1,
        fillColor: Colors.transparent,
        hintText: 'Email',
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _buildPhoneNumberTextField() {
    return Form(
      key: phoneNumberKey,
      child: MyTextFormField(
        controller: phoneNumberCntlr,
        maxLines: 1,
        fillColor: Colors.transparent,
        hintText: 'Phone number',
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _buildStreetTextField() {
    return Form(
      key: streetKey,
      child: MyTextFormField(
        controller: streetCntlr,
        maxLines: 1,
        fillColor: Colors.transparent,
        hintText: 'Street',
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _buildStreetNumberTextField() {
    return Form(
      key: streetNumberKey,
      child: MyTextFormField(
        controller: streetNumberCntlr,
        maxLines: 1,
        fillColor: Colors.transparent,
        hintText: 'Nr',
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _buildPostcodeTextField() {
    return Form(
      key: postcodeKey,
      child: MyTextFormField(
        controller: postcode,
        maxLines: 1,
        fillColor: Colors.transparent,
        hintText: 'Post code',
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _buildCityTextField() {
    return Form(
      key: cityKey,
      child: MyTextFormField(
        controller: cityCntlr,
        maxLines: 1,
        fillColor: Colors.transparent,
        hintText: 'City',
        textInputAction: TextInputAction.next,
      ),
    );
  }
}