import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/church_model.dart';
import 'package:cop_belgium/models/service_time_model.dart';
import 'package:cop_belgium/screens/churches_screen/create_service_time_screen.dart';
import 'package:cop_belgium/screens/churches_screen/edit_service_time_screen.dart';
import 'package:cop_belgium/screens/churches_screen/widgets/build_tile.dart';
import 'package:cop_belgium/screens/events_screen/edit_event_screen.dart';
import 'package:cop_belgium/services/fire_storage.dart';
import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/date_picker.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/utilities/image_picker.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:cop_belgium/widgets/textfield.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uuid/uuid.dart';

class CreateChurchScreen extends StatefulWidget {
  const CreateChurchScreen({Key? key}) : super(key: key);

  @override
  State<CreateChurchScreen> createState() => _CreateChurchScreenState();
}

class _CreateChurchScreenState extends State<CreateChurchScreen> {
  final TextEditingController churchNameCntlr = TextEditingController();
  final TextEditingController streetCntlr = TextEditingController();
  final TextEditingController streetNumberCntlr = TextEditingController();
  final TextEditingController cityCntlr = TextEditingController();
  final TextEditingController postcodeCntlr = TextEditingController();
  final TextEditingController phoneNumberCntlr = TextEditingController();
  final TextEditingController emailCntrl = TextEditingController();
  final TextEditingController leaderCntrl = TextEditingController();

  final churchNameKey = GlobalKey<FormState>();
  final streetKey = GlobalKey<FormState>();
  final streetNumberKey = GlobalKey<FormState>();
  final cityKey = GlobalKey<FormState>();
  final postcodeKey = GlobalKey<FormState>();
  final phoneNumberKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();
  final leaderKey = GlobalKey<FormState>();

  MyImagePicker churchImagePicker = MyImagePicker();
  MyImagePicker leaderImagePicker = MyImagePicker();

  String dropdownValue = 'Monday';
  String province = 'Antwerpen';
  List<String> provinces = [
    'Antwerpen',
    'Henegouwen',
    'Limburg',
    'Luik',
    'Luxemburg',
    'Namen',
    'Oost-Vlaanderen',
    'Vlaams-Brabant',
    'Waals-Brabant',
    'West-Vlaanderen'
  ];

  List<ServiceTimeModel> serviceTimes = [];

  Future<void> pickChurchImage() async {
    FocusScope.of(context).unfocus();
    await churchImagePicker.showBottomSheet(
      context: context,
    ) as File?;

    setState(() {});
  }

  Future<void> pickLeaderImage() async {
    FocusScope.of(context).unfocus();
    await leaderImagePicker.showBottomSheet(
      context: context,
    ) as File?;

    setState(() {});
  }

  Future<void> createChurch() async {
    try {
      final hasConnection = await ConnectionChecker().checkConnection();

      if (hasConnection) {
        final validChurchName = churchNameKey.currentState?.validate();
        final validStreet = streetKey.currentState?.validate();
        final validStreetNumber = streetNumberKey.currentState?.validate();
        final validCity = cityKey.currentState?.validate();
        final validPostCode = postcodeKey.currentState?.validate();
        final validPhoneNumber = phoneNumberKey.currentState?.validate();
        final validEmail = emailKey.currentState?.validate();
        final validLeader = leaderKey.currentState?.validate();
        final validServiceLength = serviceTimes.isNotEmpty;

        if (validServiceLength == false) {
          kshowSnackbar(
            context: context,
            type: SnackBarType.error,
            text: Validators.noServiceTime,
          );
        }
        if (churchImagePicker.image == null) {
          kshowSnackbar(
            context: context,
            type: SnackBarType.error,
            text: 'Church image required',
          );
        }
        if (leaderImagePicker.image == null) {
          kshowSnackbar(
            context: context,
            type: SnackBarType.error,
            text: 'Leader image required',
          );
        }

        if (validServiceLength &&
            validChurchName == true &&
            validStreet == true &&
            validStreetNumber == true &&
            validCity == true &&
            validCity == true &&
            validPostCode == true &&
            validPhoneNumber == true &&
            validEmail == true &&
            validLeader == true &&
            leaderImagePicker.image != null &&
            churchImagePicker.image != null) {
          final church = ChurchModel(
            churchName: churchNameCntlr.text,
            phoneNumber: phoneNumberCntlr.text,
            email: emailCntrl.text,
            leaderInfo: {
              'leader': leaderCntrl.text,
            },
            serviceTime: serviceTimes,
            street: streetCntlr.text,
            streetNumber: streetNumberCntlr.text,
            city: cityCntlr.text,
            postCode: postcodeCntlr.text,
            province: province,
          );

          print(church.toMap());
          EasyLoading.show();

          final doc = await FirebaseFirestore.instance
              .collection('churches')
              .add(church.toMap());
          String churchImagePath = 'churches/${doc.id}/images/';

          final churchImageURL = await FireStorage().uploadFile(
            storagePath: churchImagePath,
            file: churchImagePicker.image,
            id: doc.id,
          );
          final leaderImagUrl = await FireStorage().uploadFile(
            storagePath: churchImagePath,
            file: leaderImagePicker.image,
            id: const Uuid().v4(),
          );

          await doc.update({
            'id': doc.id,
            'imageURL': churchImageURL,
            'leaderInfo': {
              'leader': leaderCntrl.text,
              'imageUrl': leaderImagUrl,
            },
          });

          Navigator.pop(context);
        }
      } else {
        throw ConnectionChecker.connectionException;
      }
    } on FirebaseException catch (e) {
      kshowSnackbar(
        context: context,
        type: SnackBarType.error,
        text: e.message ?? '',
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void dispose() {
    churchNameCntlr.dispose();
    streetCntlr.dispose();
    streetNumberCntlr.dispose();
    cityCntlr.dispose();
    postcodeCntlr.dispose();
    phoneNumberCntlr.dispose();
    emailCntrl.dispose();
    leaderCntrl.dispose();

    churchNameKey.currentState?.reset();
    streetKey.currentState?.reset();
    streetNumberKey.currentState?.reset();
    cityKey.currentState?.reset();
    postcodeKey.currentState?.reset();
    phoneNumberKey.currentState?.reset();
    emailKey.currentState?.reset();
    leaderKey.currentState?.reset();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Church'),
        leading: kBackButton(context: context),
        actions: [
          _buildCreateButton(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildChurchImage(),
              Padding(
                padding: const EdgeInsets.all(kBodyPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildChurchNameField(),
                    _buildStreetField(),
                    _buildStreetNumberField(),
                    _buildCityTextField(),
                    _buildPostcodeField(),
                    _buildProvinceDropDown(),
                    _buildEmailField(),
                    _buildPhoneNumberField(),
                    const SizedBox(height: kContentSpacing12),
                    _buildLeaderTile(),
                    const Divider(),
                    _buildServiceTimes(),
                    const SizedBox(height: kContentSpacing32),
                    _buildAddServiceButton(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateButton() {
    return TextButton(
      child: const Text(
        'CREATE',
        style: kSFBody,
      ),
      onPressed: createChurch,
    );
  }

  Widget _buildChurchImage() {
    ImageProvider? image;

    Widget child = const Icon(Icons.collections_outlined, color: kBlack);

    if (churchImagePicker.image != null &&
        churchImagePicker.image?.path != null) {
      image = Image.file(churchImagePicker.image!).image;
      child = Container();
    }

    return Container(
      height: 260,
      decoration: BoxDecoration(
        image: image != null
            ? DecorationImage(image: image, fit: BoxFit.cover)
            : null,
        color: kGrey,
      ),
      child: TextButton(
        onPressed: pickChurchImage,
        style: kTextButtonStyle,
        child: Center(
          child: child,
        ),
      ),
    );
  }

  Widget _buildChurchNameField() {
    return Form(
      key: churchNameKey,
      child: MyTextFormField(
        controller: churchNameCntlr,
        maxLines: 1,
        fillColor: Colors.transparent,
        hintText: 'Church name',
        textInputAction: TextInputAction.next,
        validator: Validators.textValidator,
        onChanged: (value) {
          churchNameKey.currentState?.validate();
        },
      ),
    );
  }

  Widget _buildStreetField() {
    return Form(
      key: streetKey,
      child: MyTextFormField(
        controller: streetCntlr,
        maxLines: 1,
        fillColor: Colors.transparent,
        hintText: 'Street',
        textInputAction: TextInputAction.next,
        validator: Validators.textValidator,
        onChanged: (value) {
          streetKey.currentState?.validate();
        },
      ),
    );
  }

  Widget _buildStreetNumberField() {
    return Form(
      key: streetNumberKey,
      child: MyTextFormField(
        controller: streetNumberCntlr,
        maxLines: 1,
        fillColor: Colors.transparent,
        hintText: 'Street number',
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        validator: Validators.textValidator,
        onChanged: (value) {
          streetNumberKey.currentState?.validate();
        },
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
        validator: Validators.textValidator,
        onChanged: (value) {
          cityKey.currentState?.validate();
        },
      ),
    );
  }

  Widget _buildPostcodeField() {
    return Form(
      key: postcodeKey,
      child: MyTextFormField(
        controller: postcodeCntlr,
        maxLines: 1,
        fillColor: Colors.transparent,
        hintText: 'Post code',
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        validator: Validators.textValidator,
        onChanged: (value) {
          postcodeKey.currentState?.validate();
        },
      ),
    );
  }

  Widget _buildProvinceDropDown() {
    return Container(
      padding: const EdgeInsets.all(kCardContentPadding),
      child: DropdownButton<String>(
        isExpanded: true,
        icon: const Icon(
          Icons.expand_more_outlined,
          color: kBlack,
        ),
        style: kSFBody,
        underline: Container(),
        value: province,
        items: provinces.map((provincie) {
          return DropdownMenuItem<String>(
            child: Text(provincie),
            value: provincie,
          );
        }).toList(),
        onChanged: (value) {
          province = value!;
          setState(() {});
        },
      ),
    );
  }

  Widget _buildEmailField() {
    return Form(
      key: emailKey,
      child: MyTextFormField(
        controller: emailCntrl,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        fillColor: Colors.transparent,
        hintText: 'Email',
        textInputAction: TextInputAction.next,
        validator: Validators.emailValidator,
        onChanged: (value) {
          emailKey.currentState?.validate();
        },
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return Form(
      key: phoneNumberKey,
      child: MyTextFormField(
        controller: phoneNumberCntlr,
        maxLines: 1,
        fillColor: Colors.transparent,
        hintText: 'Phone number',
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.phone,
        validator: Validators.phoneNumberValidator,
        onChanged: (value) {
          phoneNumberKey.currentState?.validate();
        },
      ),
    );
  }

  Widget _buildLeaderTile() {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          _buildAvatar(),
          const SizedBox(width: kContentSpacing8),
          _buildLeaderField(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    ImageProvider? backgroundImage;

    Widget child = const Icon(Icons.person_outline_outlined, color: kBlack);

    if (leaderImagePicker.image != null &&
        leaderImagePicker.image?.path != null) {
      backgroundImage = Image.file(leaderImagePicker.image!).image;
      child = Container();
    }
    return CircleAvatar(
      radius: 40,
      backgroundColor: kBlueLight,
      backgroundImage: backgroundImage,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        child: TextButton(
          onPressed: pickLeaderImage,
          style: kTextButtonStyle,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderField() {
    return Expanded(
      child: Form(
        key: leaderKey,
        child: MyTextFormField(
          controller: leaderCntrl,
          fillColor: Colors.transparent,
          hintText: 'Leader',
          maxLines: 1,
          textInputAction: TextInputAction.done,
          validator: Validators.textValidator,
          onChanged: (value) {
            leaderKey.currentState?.validate();
          },
        ),
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
      itemCount: serviceTimes.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ServiceTimeCard(
          key: ObjectKey(serviceTimes[index]),
          serviceTime: serviceTimes[index],
          edit: () async {
            ServiceTimeModel serviceTime = await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => EditServiceTimeScreen(
                  serviceTime: serviceTimes[index],
                ),
              ),
            );
            serviceTimes.removeAt(index);
            serviceTimes.insert(index, serviceTime);
            setState(() {});
          },
          delete: () {
            serviceTimes.removeAt(index);
            setState(() {});
          },
        );
      },
    );
  }

  Widget _buildAddServiceButton() {
    return Buttons.buildButton(
      width: double.infinity,
      context: context,
      btnText: 'Add service time',
      onPressed: () async {
        FocusScope.of(context).unfocus();
        ServiceTimeModel? serviceTime = await Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => AddServiceTimeScreen(
              serviceTimeModel: ServiceTimeModel(
                day: 'Sunday',
                time: DateTime.now(),
                description: null,
              ),
            ),
          ),
        );
        if (serviceTime != null) {
          serviceTimes.add(serviceTime);
        }
        setState(() {});
      },
    );
  }
}

class ServiceTimeCard extends StatelessWidget {
  final ServiceTimeModel serviceTime;
  final VoidCallback delete;
  final VoidCallback edit;

  const ServiceTimeCard({
    Key? key,
    required this.serviceTime,
    required this.delete,
    required this.edit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildHeaderText() {
      return Container(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Service Time', style: kSFBody),
            Row(
              children: [
                TextButton(
                  child: const Icon(
                    Icons.delete_outline_outlined,
                    color: kBlack,
                  ),
                  onPressed: delete,
                ),
                TextButton(
                  child: const Icon(
                    Icons.edit_outlined,
                    color: kBlack,
                  ),
                  onPressed: edit,
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget _buildDayAndTime() {
      return ServiceTimeTile(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              serviceTime.day ?? '',
              style: kSFBody,
            ),
            Text(
              FormalDates.formatHm(date: serviceTime.time),
              style: kSFBody,
            ),
          ],
        ),
        onPressed: null,
      );
    }

    Widget _buildDescriptionField() {
      return MyTextFormField(
        initialValue: serviceTime.description,
        hintText: 'Description (optional)',
        maxLines: null,
        readOnly: true,
      );
    }

    return Column(
      children: [
        const SizedBox(height: kContentSpacing8),
        _buildHeaderText(),
        const SizedBox(height: kContentSpacing8),
        _buildDayAndTime(),
        const SizedBox(height: kContentSpacing8),
        _buildDescriptionField(),
      ],
    );
  }
}
