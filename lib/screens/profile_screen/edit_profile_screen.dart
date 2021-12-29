import 'package:cop_belgium/utilities/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cop_belgium/models/user_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/checkbox.dart';
import 'package:cop_belgium/widgets/textfiel.dart';

class EditProfileScreen extends StatefulWidget {
  final CopUser? user;
  static String editProfileScreen = 'editProfileScreen';
  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final User? _user = FirebaseAuth.instance.currentUser;

  bool isSubmit = false;

  bool isLoading = false;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  // String? selectedChurchLocation;
  String? gender;

  @override
  void initState() {
    super.initState();

    setState(() {
      gender = widget.user!.gender;
      // selectedChurchLocation = widget.user!.church;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                // _buildLocationSelector(),
                // const SizedBox(height: 5),
                // _locationValidator(),
                const SizedBox(height: kTextFieldSpacing),
                _buildGenderSelector(),
                const SizedBox(height: kTextFieldSpacing),
                _buildDeleteReset()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    if (_user?.photoURL != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(_user!.photoURL!),
        radius: 60,
        backgroundColor: kBlueDark,
        child: TextButton(
          // splash effect
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
          onPressed: () {},
        ),
      );
    }
    return const CircleAvatar(
      radius: 60,
      backgroundColor: kBlueDark,
      child: Icon(FontAwesomeIcons.camera),
    );
  }

  Widget _buildDeleteReset() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 45,
          child: OutlinedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(kButtonRadius),
                  ),
                ),
              ),
            ),
            onPressed: () {
              _showDeleteAlert();
            },
            child: const Text(
              'Delete Account',
              style: kSFBodyBold,
            ),
          ),
        ),
        const SizedBox(width: 20),
        _buildBtn(
          btText: 'Reset Password',
          textColor: kBlueDark,
          backgroundColor: kGreenLight2,
          onPressed: () async {
            await _showConformationAlert();
          },
        ),
      ],
    );
  }

  // Widget _locationValidator() {
  //   // shows error text if the location is null

  //   if (selectedChurchLocation == null && isSubmit == true) {
  //     return Text(
  //       'Please select church location',
  //       style: TextStyle(color: Colors.red.shade700, fontSize: 13),
  //     );
  //   } else {
  //     return Container();
  //   }
  // }

  // Widget _buildLocationSelector() {
  //   return ChurchSelctor().buildChurchSelectorTile(
  //     city: selectedChurchLocation,
  //     onChanged: (value) {
  //       setState(() {
  //         selectedChurchLocation = value;
  //         FocusScope.of(context).unfocus();
  //       });
  //     },
  //     context: context,
  //   );
  // }

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
            validator: Validators.emailTextValidator,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              email = value;
            },
          ),
        ),
        const SizedBox(height: kTextFieldSpacing),
        Form(
          key: _passwordFormKey,
          child: MyTextField(
            validator: Validators.passwordTextValidator,
            hintText: 'Password',
            obscureText: true,
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              password = value;
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
            onPressed: () => Navigator.pop(context, 'cancel'),
            child: const Text('OK', style: kSFCaptionBold),
          ),
        ],
      ),
    );
  }

  Future<String?> _showDeleteAlert() async {
    const String _deleteText =
        'Are you sure you want to delete your whole account? All saved data will be lost.';
    return await showDialog<String?>(
      barrierDismissible: false,
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
        content: const Text(_deleteText, style: kSFBody),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'ok'),
            child: Text(
              'Delete Account',
              style: kSFCaptionBold.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'cancel'),
            child: const Text('Cancel', style: kSFCaptionBold),
          ),
        ],
      ),
    );
  }

  Widget _buildBtn({
    required String btText,
    VoidCallback? onPressed,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return SizedBox(
      height: kButtonSize,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            backgroundColor,
          ),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(kButtonRadius),
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          btText,
          style: kSFBodyBold.copyWith(color: textColor),
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
