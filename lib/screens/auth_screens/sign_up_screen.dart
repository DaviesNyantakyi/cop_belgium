import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cop_belgium/screens/all_screens.dart';
import 'package:cop_belgium/services/firebase_auth.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:cop_belgium/utilities/church_selector.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/checkbox.dart';
import 'package:cop_belgium/widgets/textfiel.dart';

class SignUpScreen extends StatefulWidget {
  static String signUpScreen = 'signUpScreen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  bool isSubmit = false;
  bool isLoading = false;

  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? selectedLocation;
  String? gender;

  Future<void> submit() async {
    setState(() {
      isSubmit = true;
    });
    bool nameIsValid = _nameFormKey.currentState!.validate();
    bool emailIsValid = _emailFormKey.currentState!.validate();
    bool passworIsValid = _passwordFormKey.currentState!.validate();

    if (nameIsValid &&
        emailIsValid &&
        passworIsValid &&
        gender != null &&
        selectedLocation != null) {
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

        final user = await Authentication().signUpWithEmail(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          selectedChurch: selectedLocation,
          gender: gender,
        );
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        if (user != null) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        debugPrint(e.toString());
        await EasyLoading.dismiss();
        kshowSnackbar(
          backgroundColor: kRedLight2,
          context: context,
          child: Text(
            e.message.toString(),
            style: kSFBody,
          ),
        );
      } finally {
        if (mounted) {
          setState(() {
            isSubmit = false;
          });
        }
        await EasyLoading.dismiss();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20)
                .copyWith(top: kBodyPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTfFirstLastName(),
                const SizedBox(height: kTextFieldSpacing),
                _buildForm(),
                const SizedBox(height: kTextFieldSpacing),
                _buildLocationSelector(),
                const SizedBox(height: 5),
                _locationValidator(),
                const SizedBox(height: kTextFieldSpacing),
                _buildGenderSelector(),
                const SizedBox(height: kButtonSpacing),
                _buildSingUpBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationSelector() {
    return ChurchSelctor().buildChurchSelectorTile(
      city: selectedLocation,
      onChanged: (value) {
        setState(() {
          selectedLocation = value;
        });
      },
      context: context,
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        Form(
          key: _emailFormKey,
          child: MyTextField(
            hintText: 'Email',
            obscureText: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter email';
              }
              if (!value.isEmail()) {
                return 'Please enter valid email address';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              email = value;
            },
          ),
        ),
        const SizedBox(height: kTextFieldSpacing),
        Form(
          key: _passwordFormKey,
          child: MyTextField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }

              if (!value.isPasswordEasy()) {
                return 'Password must contain at least 8 characters';
              }

              return null;
            },
            hintText: 'Password',
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTfFirstLastName() {
    return Form(
      key: _nameFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyTextField(
            hintText: 'First Name',
            obscureText: false,
            validator: (value) {
              firstName = value;
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }

              // only letters
              if (!value.isAlphabet()) {
                return 'Name must contain only letters ';
              }
            },
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              debugPrint(value);
            },
          ),
          const SizedBox(height: kTextFieldSpacing),
          MyTextField(
            hintText: 'Last Name',
            obscureText: false,
            validator: (value) {
              lastName = value;
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }

              // only letters
              if (!value.isAlphabet()) {
                return 'Name must contain only letters ';
              }
            },
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              debugPrint(value);
            },
          ),
        ],
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
        const SizedBox(height: 5),
        _genderValidator()
      ],
    );
  }

  dynamic _genderValidator() {
    if (gender == null && isSubmit == true) {
      return Text(
        'Please select your gender',
        style: TextStyle(color: Colors.red.shade700, fontSize: 13),
      );
    } else {
      return Container();
    }
  }

  dynamic _locationValidator() {
    // shows error text if the location is null

    if (selectedLocation == null && isSubmit == true) {
      return Text(
        'Please select church location',
        style: TextStyle(color: Colors.red.shade700, fontSize: 13),
      );
    } else {
      return Container();
    }
  }

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      leading: Container(
        margin: const EdgeInsets.symmetric(horizontal: kAppbarPadding),
        child: TextButton(
          style: kTextButtonStyle,
          child: const Icon(
            FontAwesomeIcons.chevronLeft,
            color: kBlueDark,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      title: const Text(
        'Sing Up',
        style: kSFCaptionBold,
      ),
    );
  }

  Widget _buildSocialBt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          heroTag: 'bt1',
          elevation: 1,
          backgroundColor: kBlueLight2,
          child: Image.asset(
            'assets/images/logos/google.png',
            height: 28,
          ),
          onPressed: () async {
            await Navigator.pushReplacementNamed(
              context,
              BottomNavSelectorPage.bottomNavSelectorPage,
            );
          },
        ),
        const SizedBox(width: 16),
        FloatingActionButton(
          heroTag: 'bt2',
          elevation: 1,
          backgroundColor: kBlueLight2,
          child: Image.asset(
            'assets/images/logos/apple.png',
            height: 28,
          ),
          onPressed: () async {
            await Navigator.pushReplacementNamed(
              context,
              BottomNavSelectorPage.bottomNavSelectorPage,
            );
          },
        ),
      ],
    );
  }

  Widget _buildSingUpBtn() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            isLoading ? kGrey : kYellow,
          ),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(kButtonRadius),
              ),
            ),
          ),
        ),
        onPressed: isLoading ? null : submit,
        child: const Text(
          'Sing Up',
          style: kSFBodyBold,
        ),
      ),
    );
  }
}
