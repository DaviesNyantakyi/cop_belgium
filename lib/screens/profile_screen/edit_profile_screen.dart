import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cop_belgium/services/cloud_firestore.dart';
import 'package:cop_belgium/services/fire_storage.dart';
import 'package:cop_belgium/services/firebase_auth.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:cop_belgium/models/user_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/checkbox.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// TODO: if the user information is the same do not update information
// TODO: ask for permision gallary and camera (check whatsaap process)

class EditProfileScreen extends StatefulWidget {
  final CopUser? user;
  static String editProfileScreen = 'editProfileScreen';
  const EditProfileScreen({Key? key, this.user}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool hasConnection = false;

  bool isLoading = false;
  bool showPassword = false;

  String? photoUrl;
  String? nameErrorText;
  String? emailErrorText;
  String? passwordErrorText;
  String? birthDateErrorText;
  String? genderErrorText;

  bool? isAdimin;

  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController firstNameCntlr = TextEditingController();
  TextEditingController lastNameCntlr = TextEditingController();
  TextEditingController emailCntlr = TextEditingController();
  TextEditingController passwordCntlr = TextEditingController();
  TextEditingController genderCntlr = TextEditingController();
  DateTime? birthDate;

  final ImagePicker _picker = ImagePicker();

  File? image;

  @override
  void initState() {
    super.initState();

    initUserInfo();
  }

  Future<void> initUserInfo() async {
    setState(() {
      firstNameCntlr.text = widget.user!.firstName;
      firstNameCntlr.text = widget.user!.firstName;
      lastNameCntlr.text = widget.user!.lastName;
      emailCntlr.text = widget.user!.email;
      genderCntlr.text = widget.user!.gender;
      photoUrl = widget.user!.photoUrl;
      isAdimin = widget.user!.isAdmin;
      birthDate = widget.user!.birthDate;
    });
  }

  Future<void> resetPassword() async {
    FocusScope.of(context).unfocus();
    EasyLoading.show();
    try {
      isLoading = true;

      if (mounted) {
        setState(() {});
      }

      await FireAuth().sendResetPassword(email: auth.currentUser!.email);

      _showMailConformationAlert();

      if (mounted) {
        setState(() {});
      }
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      kshowSnackbar(
        context: context,
        errorType: 'error',
        text: e.message!,
      );
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      EasyLoading.dismiss();
      if (mounted) {
        setState(() {});
      }
    }
  }

  bool validateForm() {
    nameErrorText = Validators.nameValidator(
      firstName: firstNameCntlr.text,
      lastName: lastNameCntlr.text,
    );
    emailErrorText = Validators.emailValidator(
      email: emailCntlr.text,
    );

    birthDateErrorText = Validators.birthdayValidator(date: birthDate);

    genderErrorText = Validators.genderValidator(gender: genderCntlr.text);

    if (nameErrorText == null &&
        emailErrorText == null &&
        birthDateErrorText == null &&
        genderErrorText == null) {
      return true;
    }
    return false;
  }

  Future<void> updateAccount() async {
    FocusScope.of(context).unfocus();
    EasyLoading.show();
    try {
      isLoading = true;

      bool isValid = validateForm();

      if (isValid) {
        // final user = CopUser(
        //   firstName: firstNameCntlr.text,
        //   lastName: lastNameCntlr.text,
        //   email: emailCntlr.text,
        //   birthDate: birthDate!,
        //   gender: genderCntlr.text,
        //   isAdmin: isAdimin!,
        // );
        if (mounted) {
          setState(() {});
        }

        await FireStorage().uploadProfileImage(image: image);
        await CloudFireStore().updateUserInfo(
          firstName: firstNameCntlr.text,
          lastName: lastNameCntlr.text,
          email: emailCntlr.text,
          gender: genderCntlr.text,
        );

        await EasyLoading.dismiss();
      }
      Navigator.pop(context);

      if (mounted) {
        setState(() {});
      }
    } on FirebaseAuthException catch (e) {
      await EasyLoading.dismiss();
      kshowSnackbar(
        context: context,
        errorType: 'error',
        text: e.message!,
      );
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      EasyLoading.dismiss();
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> deleteAccount() async {
    if (passwordCntlr.text.isNotEmpty) {
      try {
        if (mounted) {
          setState(() {
            isLoading = true;
          });
        }
        await EasyLoading.show(
          maskType: EasyLoadingMaskType.black,
          indicator: const CircularProgressIndicator(
            color: kBlack,
          ),
        );
        await FireAuth().deleteUser(password: passwordCntlr.text);

        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        await EasyLoading.dismiss();
        Navigator.of(context)
          ..pop()
          ..pop()
          ..pop();
      } on FirebaseException catch (e) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        await EasyLoading.dismiss();
        Navigator.pop(context);
        kshowSnackbar(
          context: context,
          errorType: 'error',
          text: e.message!,
        );
      } catch (e) {
        debugPrint(e.toString());
        Navigator.pop(context);
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        await EasyLoading.dismiss();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
            child: Column(
              children: [
                _buildAvatar(),
                const SizedBox(height: kButtonSpacing),
                _buildForm(),
                const SizedBox(height: kTextFieldSpacing),
                _buildBirthdayPicker(),
                const SizedBox(height: kButtonSpacing),
                _buildGenderSelector(),
                const SizedBox(height: 24),
                _buildDeleteReset()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    if (image != null) {
      return CircleAvatar(
        backgroundImage: Image.file(image!).image,
        radius: 60,
        backgroundColor: kBlack,
        child: TextButton(
          style: kTextButtonStyle.copyWith(
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
            ),
          ),
          child: Container(),
          onPressed: () async {
            await showBottomSheet();
            setState(() {});
          },
        ),
      );
    }
    if (photoUrl != null) {
      return CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(photoUrl!),
        radius: 60,
        backgroundColor: kBlack,
        child: TextButton(
          style: kTextButtonStyle.copyWith(
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
            ),
          ),
          child: Container(),
          onPressed: () async {
            await showBottomSheet();
          },
        ),
      );
    }

    return CircleAvatar(
      radius: 60,
      backgroundColor: kBlack,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: TextButton(
            style: kTextButtonStyle,
            child: const Icon(
              Icons.photo_camera_outlined,
              color: Colors.white,
            ),
            onPressed: () async {
              await showBottomSheet();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteReset() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          _buildBtn(
            btText: 'Reset Password',
            textColor: kBlack,
            onPressed: resetPassword,
          ),
          _buildBtn(
            btText: 'Delete account',
            textColor: kRed,
            onPressed: () async {
              await _showDeleteAlert();
            },
          ),
        ],
      ),
    );
  }

  Future<void> pickImage({required String type}) async {
    final source = type == 'camera' ? ImageSource.camera : ImageSource.gallery;
    try {
      final pickedImage = await _picker.pickImage(source: source);

      File? croppedImage = await ImageCropper.cropImage(
        sourcePath: pickedImage!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: kBlack,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );

      if (croppedImage != null) {
        setState(() {
          image = File(croppedImage.path);
        });
      }

      Navigator.pop(context);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: MyTextField(
                controller: firstNameCntlr,
                hintText: 'First Name',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  nameErrorText = Validators.nameValidator(
                    firstName: value,
                    lastName: lastNameCntlr.text,
                  );

                  setState(() {});
                },
              ),
            ),
            const SizedBox(width: kTextFieldSpacing),
            Expanded(
              child: MyTextField(
                controller: lastNameCntlr,
                hintText: 'Last Name',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  nameErrorText = Validators.nameValidator(
                    firstName: firstNameCntlr.text,
                    lastName: value,
                  );
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        _buildNameErrorText(),
        const SizedBox(height: kTextFieldSpacing),
        MyTextField(
          controller: emailCntlr,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: (value) {
            emailErrorText = Validators.emailValidator(email: value);
            setState(() {});
          },
        ),
        _buildEmailErrorText(),
      ],
    );
  }

  Widget _buildNameErrorText() {
    if (nameErrorText == null) {
      return Container();
    }
    return Column(
      children: [
        const SizedBox(height: 5),
        Text(
          nameErrorText!,
          style: kSFCaption.copyWith(color: kRed),
        )
      ],
    );
  }

  Widget _buildEmailErrorText() {
    if (emailErrorText == null) {
      return Container();
    }
    return Column(
      children: [
        const SizedBox(height: 5),
        Text(
          emailErrorText!,
          style: kSFCaption.copyWith(color: kRed),
        )
      ],
    );
  }

  Widget _buildBirthDateErrorText() {
    if (birthDateErrorText == null || birthDate != null) {
      return Container();
    }
    return Column(
      children: [
        const SizedBox(height: 5),
        Text(
          birthDateErrorText!,
          style: kSFCaption.copyWith(color: kRed),
        )
      ],
    );
  }

  Widget _buildBirthdayPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 64,
          decoration: const BoxDecoration(
            color: kBlueLight,
            borderRadius: BorderRadius.all(
              Radius.circular(
                kButtonRadius,
              ),
            ),
          ),
          child: TextButton(
            onPressed: showDatePicker,
            style: kTextButtonStyle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    color: kBlack,
                    size: kIconSize,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    birthDate == null
                        ? 'Birthday'
                        : FormalDates.formatDmyyyy(date: birthDate),
                    style: birthDate == null ? kSFBodyBold : kSFBodyBold,
                  )
                ],
              ),
            ),
          ),
        ),
        _buildBirthDateErrorText()
      ],
    );
  }

  Future<void> showDatePicker() async {
    FocusScope.of(context).requestFocus(FocusNode());
    await showMyBottomSheet(
      isDismissible: false,
      context: context,
      height: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 200,
              child: Theme(
                data: ThemeData(),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: birthDate,
                  maximumDate: DateTime.now(),
                  minimumDate: DateTime(1900, 01, 31),
                  minimumYear: 1900,
                  maximumYear: DateTime.now().year,
                  onDateTimeChanged: (date) {
                    HapticFeedback.lightImpact();
                    birthDate = date;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
              ),
            ),
            Buttons.buildBtn(
              context: context,
              btnText: 'Done',
              height: kButtonHeight,
              width: double.infinity,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _builGenderErrorText() {
    if (genderErrorText == null) {
      return Container();
    }
    return Column(
      children: [
        const SizedBox(height: 5),
        Text(
          genderErrorText!,
          style: kSFCaption.copyWith(color: kRed),
        )
      ],
    );
  }

  Future<String?> _showMailConformationAlert() async {
    return await showDialog<String?>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(kButtonRadius),
          ),
        ),
        title: const Text(
          'Check your mail',
          style: kSFBodyBold,
        ),
        content: const Text(
            'We have sent password recovery instructions to your email.',
            style: kSFBody),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: kSFCaptionBold),
          ),
        ],
      ),
    );
  }

  Future<String?> _showDeleteAlert() async {
    const String _deleteConformationText =
        'Confirm you want to delete this account by typing its password.';
    return await showDialog<String?>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(kButtonRadius),
          ),
        ),
        title: const Text(_deleteConformationText, style: kSFBodyBold),
        content: MyTextField(
          hintText: 'Password',
          obscureText: true,
          onChanged: (value) {
            passwordCntlr.text = value;
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: kSFBodyBold),
          ),
          const SizedBox(height: kButtonSpacing),
          TextButton(
            onPressed: () => deleteAccount,
            child: Text('Delete account',
                style: kSFBodyBold.copyWith(color: kRed)),
          ),
          const SizedBox(height: kTextFieldSpacing)
        ],
      ),
    );
  }

  Widget _buildBtn({
    required String btText,
    VoidCallback? onPressed,
    Color? textColor,
  }) {
    return SizedBox(
      height: kButtonHeight,
      child: TextButton(
        style: kTextButtonStyle.copyWith(
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(kButtonRadius),
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            btText,
            style: kSFBodyBold.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }

  Future<void> showBottomSheet() async {
    await showMyFastingBottomSheet(
      height: 170,
      context: context,
      child: Material(
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () async {
                    await pickImage(type: 'camera');
                  },
                  leading: const Icon(
                    Icons.photo_camera_outlined,
                    color: kBlack,
                    size: kIconSize,
                  ),
                  title: const Text(
                    'Camera',
                    style: kSFBody,
                  ),
                ),
                ListTile(
                  onTap: () async {
                    await pickImage(type: 'gallery');
                  },
                  leading: const Icon(
                    Icons.collections_outlined,
                    color: kBlack,
                    size: kIconSize,
                  ),
                  title: const Text(
                    'Gallery',
                    style: kSFBody,
                  ),
                ),
                image != null || photoUrl != null
                    ? ListTile(
                        onTap: () async {
                          image = null;
                          photoUrl = null;

                          //TODO: add delete photoUrl
                          setState(() {});
                          Navigator.pop(context);
                        },
                        leading: const Icon(
                          Icons.delete_outline_outlined,
                          color: kRed,
                          size: kIconSize,
                        ),
                        title: Text(
                          'Delete',
                          style: kSFBody.copyWith(color: kRed),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Gender',
            style: kSFBody,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyCheckBox(
              label: 'Male',
              value: 'male',
              groupsValue: genderCntlr.text,
              onChanged: (value) {
                setState(() {
                  genderCntlr.text = value;
                });
              },
            ),
            const SizedBox(width: 10),
            MyCheckBox(
              label: 'Female',
              value: 'female',
              groupsValue: genderCntlr.text,
              onChanged: (value) {
                setState(() {
                  genderCntlr.text = value;
                });
              },
            ),
          ],
        ),
        _builGenderErrorText()
      ],
    );
  }

  dynamic _buildAppbar() {
    return AppBar(
      title: const Text(
        'Edit Profile',
        style: kSFBodyBold,
      ),
      leading: TextButton(
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.chevron_left_outlined,
            color: kBlack,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        TextButton(
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Save',
              style: kSFBodyBold,
            ),
          ),
          onPressed: isLoading ? null : updateAccount,
        ),
      ],
    );
  }
}
