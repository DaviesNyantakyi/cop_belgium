import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/church_model.dart';
import 'package:cop_belgium/models/service_time_model.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

  File? churchImage;
  File? leaderImage;

  String dropdownValue = 'Monday';

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

  String province = 'Antwerpen';

  Future<void> pickChurchImage() async {
    FocusScope.of(context).unfocus();
    await churchImagePicker.showBottomSheet(
      context: context,
    ) as File?;

    churchImage = churchImagePicker.image;

    setState(() {});
  }

  Future<void> pickLeaderImage() async {
    FocusScope.of(context).unfocus();
    await leaderImagePicker.showBottomSheet(
      context: context,
    ) as File?;

    leaderImage = leaderImagePicker.image;

    setState(() {});
  }

  List<ServiceTime> serviceTimes = [
    ServiceTime(
      day: 'Sunday',
      time: DateTime(2000, 01, 09, 9, 00),
      description: '',
    ),
  ];

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
            text: Validators.noServiceTimeErrorMessage,
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
            validLeader == true) {
          final church = Churchss(
            churchName: churchNameCntlr.text,
            phoneNumber: phoneNumberCntlr.text,
            email: emailCntrl.text,
            leaderInfo: {
              'leader': leaderCntrl.text,
            },
            serviceTime: serviceTimes.map((serviceTime) {
              return serviceTime.toMap();
            }).toList(),
            street: streetCntlr.text,
            streetNumber: streetNumberCntlr.text,
            city: cityCntlr.text,
            postCode: postcodeCntlr.text,
            province: province,
          );

          EasyLoading.show();
          final doc = await FirebaseFirestore.instance
              .collection('churchess')
              .add(church.toMap());
          final churchImgaeUrl = await FireStorage().uploadFile(
            storagePath: churchImagePath,
            file: churchImage,
            id: doc.id,
          );
          final leaderImagUrl = await FireStorage().uploadFile(
            storagePath: churchImagePath,
            file: leaderImage,
            id: const Uuid().v4(),
          );

          await doc.update({
            'id': doc.id,
            'image': churchImgaeUrl,
            'leaderInfo': {
              'leader': leaderCntrl.text,
              'imageUrl': leaderImagUrl,
            },
          });
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
        title: const Text('Create', style: kSFHeadLine3),
        leading: kBackButton(context: context),
        actions: [
          TextButton(
            child: const Text(
              'CREATE',
              style: kSFBody,
            ),
            onPressed: createChurch,
          )
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
                    _buildChurchTextField(),
                    _buildStreetTextField(),
                    _buildStreetNumberTextField(),
                    _buildCityTextField(),
                    _buildPostcodeTextField(),
                    _buildProvinceSelection(),
                    _buildPhoneNumberTextField(),
                    _buildEmailTextField(),
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

  Widget _buildAddServiceButton() {
    return Buttons.buildButton(
      width: double.infinity,
      context: context,
      btnText: 'Add service time',
      onPressed: () {
        serviceTimes.add(
          ServiceTime(
            day: 'Sunday',
            time: DateTime.now(),
            description: '',
          ),
        );
        setState(() {});
      },
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
        return CreateServiceTime(
          delete: () {
            print(index);
            serviceTimes.removeAt(index);
            setState(() {});
          },
          serviceTime: serviceTimes[index],
          dayOnChanged: (value) {
            serviceTimes[index].day = value;
            setState(() {});
          },
          descriptionOnChanged: (value) {
            serviceTimes[index].description = value;
            setState(() {});
          },
          timeOnChanged: (time) {
            serviceTimes[index].time = time;

            setState(() {});
          },
        );
      },
    );
  }

  Widget _buildChurchImage() {
    if (churchImage != null && churchImage?.path != null) {
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
          onPressed: pickChurchImage,
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
        onPressed: pickChurchImage,
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

  Widget _buildChurchTextField() {
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

  Widget _buildProvinceSelection() {
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

  Widget _buildEmailTextField() {
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

  Widget _buildPhoneNumberTextField() {
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

  Widget _buildStreetTextField() {
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

  Widget _buildStreetNumberTextField() {
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

  Widget _buildPostcodeTextField() {
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

  Widget _buildLeaderTile() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kBodyPadding),
      height: 100,
      child: Row(
        children: [
          _buildAvatar(),
          const SizedBox(width: kContentSpacing8),
          Expanded(
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
          )
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    if (leaderImage != null && leaderImage?.path != null) {
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
            onPressed: pickLeaderImage,
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
          onPressed: pickLeaderImage,
          style: kTextButtonStyle,
          child: const Center(
            child: Icon(Icons.person_outline_outlined, color: kBlack),
          ),
        ),
      ),
    );
  }
}

class CreateServiceTime extends StatefulWidget {
  final ServiceTime serviceTime;
  final Function(String?) dayOnChanged;
  final Function(DateTime) timeOnChanged;
  final Function(String) descriptionOnChanged;
  final VoidCallback delete;

  const CreateServiceTime({
    Key? key,
    required this.serviceTime,
    required this.descriptionOnChanged,
    required this.timeOnChanged,
    required this.dayOnChanged,
    required this.delete,
  }) : super(key: key);

  @override
  State<CreateServiceTime> createState() => _CreateServiceTimeState();
}

class _CreateServiceTimeState extends State<CreateServiceTime> {
  DatePicker datePicker = DatePicker();

  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Service Time', style: kSFBody),
            TextButton(
              child: const Icon(
                Icons.delete_outline_outlined,
                color: kBlack,
              ),
              onPressed: widget.delete,
            )
          ],
        ),
        const SizedBox(height: kContentSpacing8),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: kBlueLight,
            borderRadius: BorderRadius.all(
              Radius.circular(kButtonRadius),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(kCardContentPadding),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 4,
                  child: DropdownButton<String>(
                    value: widget.serviceTime.day,
                    isExpanded: true,
                    underline: Container(),
                    icon: const Icon(
                      Icons.expand_more_outlined,
                      color: kBlack,
                    ),
                    style: kSFBody,
                    onChanged: (String? value) {
                      widget.dayOnChanged(value);
                      setState(() {});
                    },
                    items: days.map((day) {
                      return DropdownMenuItem<String>(
                        value: day,
                        child: Text(
                          day,
                          style: kSFBody,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: TextButton(
                    child: Text(
                      FormalDates.formatHm(
                        date: widget.serviceTime.time,
                      ),
                      style: kSFBody,
                    ),
                    onPressed: () async {
                      await datePicker.showDatePicker(
                        initialDate: widget.serviceTime.time,
                        maxDate: kMaxDate,
                        mode: CupertinoDatePickerMode.time,
                        context: context,
                        onChanged: (date) {
                          widget.timeOnChanged(date);
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: kContentSpacing8),
        MyTextFormField(
          hintText: 'Description (optional)',
          onChanged: widget.descriptionOnChanged,
        ),
      ],
    );
  }
}
