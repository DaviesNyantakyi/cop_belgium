import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/services/cloud_firestore.dart';
import 'package:cop_belgium/services/fire_storage.dart';
import 'package:cop_belgium/services/firebase_auth.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cop_belgium/models/user_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/checkbox.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final CopUser? user;
  static String editProfileScreen = 'editProfileScreen';
  const EditProfileScreen({Key? key, this.user}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  bool hasConnection = false;

  bool isSubmit = false;

  bool isLoading = false;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? photoUrl;
  String? password;

  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();

    initUserInfo();
  }

  Future<void> initUserInfo() async {
    setState(() {
      firstName = widget.user!.firstName;
      lastName = widget.user!.lastName;
      email = widget.user!.email;
      gender = widget.user!.gender;
      photoUrl = widget.user!.photoUrl;
    });
  }

  Future<void> submitUpdate() async {
    try {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      await EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        indicator: const CircularProgressIndicator(color: kBlueDark),
      );
      bool nameIsValid = _nameFormKey.currentState!.validate();
      bool emailIsValid = _emailFormKey.currentState!.validate();
      if (nameIsValid && emailIsValid && gender != null) {
        await FireStorage().uploadProfileImage(image: _selectedImage);
        await CloudFireStore().updateUserInfo(
          firstName: firstName!,
          lastName: lastName!,
          email: email!,
          gender: gender!,
        );
        Navigator.pop(context);
      }

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      await EasyLoading.dismiss();
      kshowSnackbar(
        errorType: 'error',
        context: context,
        text: e.message.toString(),
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      await EasyLoading.dismiss();
    }
  }

  Future<void> submitDelete() async {
    bool validPassword = _passwordFormKey.currentState!.validate();
    if (password != null && password!.isNotEmpty && validPassword) {
      try {
        if (mounted) {
          setState(() {
            isLoading = true;
          });
        }
        await EasyLoading.show(
          maskType: EasyLoadingMaskType.black,
          indicator: const CircularProgressIndicator(
            color: kBlueDark,
          ),
        );
        await Authentication().deleteUser(password: password!);

        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        await EasyLoading.dismiss();
        Navigator.of(context)
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
                const SizedBox(height: 24),
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
    if (_selectedImage != null) {
      return CircleAvatar(
        backgroundImage: Image.file(_selectedImage!).image,
        radius: 60,
        backgroundColor: kBlueDark,
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
        backgroundColor: kBlueDark,
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
      backgroundColor: kBlueDark,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: TextButton(
            style: kTextButtonStyle,
            child: const Icon(
              FontAwesomeIcons.camera,
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
            textColor: kBlueDark,
            onPressed: () async {
              String? conformation = await _showConformationAlert();
              try {
                if (conformation == 'ok') {
                  await Authentication().sendResetPassword(email: email);
                }
              } on FirebaseException catch (e) {
                kshowSnackbar(
                  context: context,
                  errorType: 'error',
                  text: e.message!,
                );
                debugPrint(e.toString());
              } catch (e) {
                Navigator.pop(context);
              }
            },
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

      if (pickedImage != null) {
        setState(() {
          _selectedImage = File(pickedImage.path);
        });
      }

      Navigator.pop(context);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget _buildForm() {
    return Column(
      children: [
        Form(
          key: _nameFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTextField(
                hintText: 'First Name',
                obscureText: false,
                initialValue: firstName,
                validator: Validators.nameValidator,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  firstName = value;
                },
              ),
              const SizedBox(height: kTextFieldSpacing),
              MyTextField(
                hintText: 'Last Name',
                obscureText: false,
                initialValue: lastName,
                validator: Validators.nameValidator,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  lastName = value;
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: kTextFieldSpacing),
        Form(
          key: _emailFormKey,
          child: MyTextField(
            hintText: 'Email',
            obscureText: false,
            initialValue: email,
            validator: Validators.emailTextValidator,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              email = value;
            },
          ),
        ),
      ],
    );
  }

  Future<String?> _showConformationAlert() async {
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
          'Check Your email',
          style: kSFHeadLine2,
        ),
        content: const Text(
            'We have send password recovery instruction to your email.',
            style: kSFBody),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'ok'),
            child: const Text('OK', style: kSFCaptionBold),
          ),
        ],
      ),
    );
  }

  Future<String?> _showDeleteAlert() async {
    const String _deleteText =
        'Are you sure you want to delete your whole account? All saved data will be lost.';
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
        title: const Text(
          'Now just a minute',
          style: kSFHeadLine2,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(_deleteText, style: kSFBodyBold),
            Text(_deleteConformationText, style: kSFBody),
          ],
        ),
        actions: <Widget>[
          Form(
            key: _passwordFormKey,
            child: MyTextField(
              hintText: 'Password',
              obscureText: true,
              validator: Validators.passwordTextValidator,
              onChanged: (value) {
                password = value;
              },
            ),
          ),
          const SizedBox(height: kButtonSpacing),
          Buttons.buildBtn(
            context: context,
            btnText: 'Delete account',
            onPressed: isLoading ? null : submitDelete,
            color: isLoading ? Colors.grey : kRed,
            fontColor: Colors.white,
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
      height: kButtonSize,
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
      height: 150,
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
                    FontAwesomeIcons.camera,
                    color: kBlueDark,
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
                    FontAwesomeIcons.images,
                    color: kBlueDark,
                  ),
                  title: const Text(
                    'Gallery',
                    style: kSFBody,
                  ),
                ),
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
              groupsValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),
            const SizedBox(width: 10),
            MyCheckBox(
              label: 'Female',
              value: 'female',
              groupsValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  dynamic _buildAppbar() {
    return AppBar(
      title: const Text(
        'Edit Profile',
        style: kSFCaptionBold,
      ),
      centerTitle: true,
      leading: TextButton(
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            FontAwesomeIcons.chevronLeft,
            color: kBlueDark,
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
              style: kSFCaptionBold,
            ),
          ),
          onPressed: isLoading ? null : submitUpdate,
        ),
      ],
    );
  }
}
