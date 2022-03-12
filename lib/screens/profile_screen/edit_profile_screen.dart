import 'package:cached_network_image/cached_network_image.dart';
import 'package:cop_belgium/services/fire_auth.dart';
import 'package:cop_belgium/utilities/date_picker.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/providers/image_picker_provider.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/widgets/dialog.dart';

import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:cop_belgium/models/user_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/checkbox.dart';
import 'package:cop_belgium/widgets/textfield.dart';
import 'package:provider/provider.dart';

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
  DateTime? birthDate;

  bool? isAdimin;

  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController firstNameCntlr = TextEditingController();
  TextEditingController lastNameCntlr = TextEditingController();
  TextEditingController emailCntlr = TextEditingController();
  TextEditingController passwordCntlr = TextEditingController();
  TextEditingController genderCntlr = TextEditingController();

  late final ImagePickerProvider imageSelector;

  DatePicker datePicker = DatePicker();

  @override
  void initState() {
    imageSelector = Provider.of<ImagePickerProvider>(context, listen: false);

    initUserInfo();

    super.initState();
  }

  @override
  void dispose() {
    imageSelector.close();
    super.dispose();
  }

  Future<void> initUserInfo() async {
    setState(() {
      // firstNameCntlr.text = widget.user!.firstName;
      // firstNameCntlr.text = widget.user!.firstName;
      // lastNameCntlr.text = widget.user!.lastName;
      // emailCntlr.text = widget.user!.email;
      // genderCntlr.text = widget.user!.gender;
      // photoUrl = widget.user!.photoUrl;
      // isAdimin = widget.user!.isAdmin;
      // birthDate = widget.user!.birthDate;
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
        type: SnackBarType.error,
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

        // await FireStorage().uploadProfileImage(image: image);
        // await CloudFireStore().updateUserInfo(
        //   firstName: firstNameCntlr.text,
        //   lastName: lastNameCntlr.text,
        //   email: emailCntlr.text,
        //   gender: genderCntlr.text,
        // );

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
        type: SnackBarType.error,
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
          type: SnackBarType.error,
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
                const SizedBox(height: kContentSpacing32),
                _buildForm(),
                const SizedBox(height: kContentSpacing8),
                _buildBirthdayPicker(),
                const SizedBox(height: kContentSpacing8),
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
    final image =
        Provider.of<ImagePickerProvider>(context, listen: true).selectedImage;
    if (image != null) {
      return CircleAvatar(
        backgroundImage: Image.file(image).image,
        radius: 60,
        backgroundColor: kBlueLight,
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
            await Provider.of<ImagePickerProvider>(context, listen: false)
                .showBottomSheet(context: context);
          },
        ),
      );
    }
    if (photoUrl != null) {
      return CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(photoUrl!),
        radius: 70,
        backgroundColor: kBlueLight,
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
            await Provider.of<ImagePickerProvider>(context, listen: false)
                .showBottomSheet(context: context);
          },
        ),
      );
    }

    return CircleAvatar(
      radius: 70,
      backgroundColor: kBlueLight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: TextButton(
            style: kTextButtonStyle,
            child: const Icon(
              Icons.person_outline_outlined,
              color: kBlack,
              size: 35,
            ),
            onPressed: () async {
              await Provider.of<ImagePickerProvider>(context, listen: false)
                  .showBottomSheet(context: context);
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
            btText: 'RESET PASSWORD',
            textColor: kBlack,
            onPressed: resetPassword,
          ),
          _buildBtn(
            btText: 'DELETE ACCOUNT',
            textColor: kRed,
            onPressed: () async {
              await _showDeleteAlert();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBirthdayPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Date of birth',
            style: kSFBody,
          ),
        ),
        const SizedBox(height: kContentSpacing12),
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
            style: kTextButtonStyle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: kBlack,
                        size: kIconSize,
                      ),
                      const SizedBox(width: 10),
                      _buildBirthDateText()
                    ],
                  ),
                ],
              ),
            ),
            onPressed: () async {
              datePicker.showDatePicker(
                initialDate: DateTime.now(),
                mode: CupertinoDatePickerMode.date,
                context: context,
                onChanged: (date) {
                  birthDate = date;
                },
              );
            },
          ),
        ),
        _buildBirthDateErrorText()
      ],
    );
  }

  Widget _buildBirthDateText() {
    return Text(
      birthDate == null
          ? FormalDates.formatEDmyyyy(date: DateTime.now())
          : FormalDates.formatEDmyyyy(date: birthDate),
      style: kSFTextFieldStyle.copyWith(
        fontWeight: birthDate == null ? FontWeight.normal : FontWeight.bold,
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextFormField(
          controller: firstNameCntlr,
          hintText: 'First Name',
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: (value) {},
        ),
        const SizedBox(height: kContentSpacing8),
        MyTextFormField(
          controller: lastNameCntlr,
          hintText: 'Last Name',
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: (value) {
            setState(() {});
          },
        ),
        _buildNameErrorText(),
        const SizedBox(height: kContentSpacing8),
        MyTextFormField(
          controller: emailCntlr,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: (value) {},
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
    return await showMyDialog(
      barrierDismissible: true,
      context: context,
      title: const Text('Check your mail', style: kSFHeadLine3),
      content: const Text(
        'We have sent password recovery instructions to your email.',
        style: kSFBody,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK', style: kSFCaptionBold),
        ),
      ],
    );
  }

  Future<String?> _showDeleteAlert() async {
    const String _deleteConformationText =
        'Confirm that you want to delete this account by entering the password.';
    return await showMyDialog(
      barrierDismissible: true,
      context: context,
      title: const Text(_deleteConformationText, style: kSFHeadLine3),
      content: MyTextFormField(
        hintText: 'Password',
        obscureText: true,
        onChanged: (value) {
          passwordCntlr.text = value;
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: kSFBody),
        ),
        const SizedBox(height: kContentSpacing32),
        TextButton(
          onPressed: () => deleteAccount,
          child: Text('Delete account', style: kSFBody.copyWith(color: kRed)),
        ),
        const SizedBox(height: kContentSpacing12)
      ],
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
            style: kSFBody.copyWith(color: textColor),
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
        style: kSFHeadLine3,
      ),
      leading: kBackButton(context: context),
      actions: [
        TextButton(
          child: const Text('Save', style: kSFBodyBold),
          onPressed: isLoading ? null : updateAccount,
        ),
      ],
    );
  }
}
