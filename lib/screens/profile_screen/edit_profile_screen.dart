import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cop_belgium/models/user_model.dart';
import 'package:cop_belgium/screens/profile_screen/profile_screen.dart';
import 'package:cop_belgium/utilities/church_selector.dart';
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
  final String _deleteText =
      'Are you sure you want to delete your whole account? All saved data will be lost.';
  String? profileImage;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? selectedChurch;

  @override
  void initState() {
    super.initState();

    setState(() {
      gender = widget.user!.gender;
      selectedChurch = widget.user!.churchLocation;
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
                CircleAvatar(
                  backgroundImage: NetworkImage(profilePhoto),
                  radius: 50,
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
                ),
                const SizedBox(height: 20),
                MyTextField.buildTF(
                  initialValue: widget.user!.firstName,
                  label: 'First Name',
                  hintText: 'John',
                  obscureText: false,
                  onChanged: (value) {},
                ),
                const SizedBox(height: kTextFieldSpacing),
                MyTextField.buildTF(
                  initialValue: widget.user!.lastName,
                  label: 'Last Name',
                  hintText: 'John',
                  obscureText: false,
                  onChanged: (value) {},
                ),
                const SizedBox(height: kTextFieldSpacing),
                MyTextField.buildTF(
                  initialValue: widget.user!.email,
                  label: 'Email',
                  hintText: 'John',
                  obscureText: false,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),
                _buildGenderSelector(),
                const SizedBox(height: 20),
                ChurchSelctor().buildChurchSelectorTile(
                  city: selectedChurch,
                  context: context,
                  onChanged: (city) {
                    setState(() {
                      selectedChurch = city;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Row(
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
                )
              ],
            ),
          ),
        ),
      ),
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
        content: Text(_deleteText, style: kSFBody),
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
