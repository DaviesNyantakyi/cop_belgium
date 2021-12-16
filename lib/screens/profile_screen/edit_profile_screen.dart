import 'package:cop_belgium/models/user_model.dart';
import 'package:cop_belgium/screens/profile_screen/profile_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:cop_belgium/widgets/checkbox.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<String> cities = [
  'Turnhout',
  'Brussel',
];

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
  String? churchLocation;

  @override
  void initState() {
    super.initState();

    setState(() {
      gender = widget.user!.gender;
      churchLocation = widget.user!.churchLocation;
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
                  backgroundColor: kDarkBlue,
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
                _buildLocationSelector(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildBt(
                      btText: 'Delete Account',
                      textColor: kRed,
                      backgroundColor: kRedLight,
                      onPressed: () async {
                        await _showDeleteAlert();
                      },
                    ),
                    const SizedBox(width: 20),
                    _buildBt(
                      btText: 'Reset Password',
                      textColor: kGreen,
                      backgroundColor: kGreenLight,
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
            child: const Text('OK', style: kSFCaption),
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
              style: kSFCaption.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'cancel'),
            child: const Text('Cancel', style: kSFCaption),
          ),
        ],
      ),
    );
  }

  Future<String?> _showLocationSelectorBottomSheet(
      {required BuildContext context}) async {
    return await showModalBottomSheet<String?>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: kBottomSheetHeight,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: cities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    cities[index],
                    style: kSFBody,
                  ),
                  onTap: () {
                    Navigator.pop(context, cities[index]);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildBt({
    required String btText,
    VoidCallback? onPressed,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return SizedBox(
      height: 48,
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

  Widget _buildLocationSelector() {
    return ListTile(
      tileColor: kBlueLight1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kButtonRadius),
        ),
      ),
      onTap: () async {
        churchLocation =
            await _showLocationSelectorBottomSheet(context: context);
        setState(() {});
      },
      leading: const Text(
        'Church Location',
        style: kSFBody,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$churchLocation',
            style: kSFBody,
          ),
        ],
      ),
    );
  }

  dynamic _buildAppbar() {
    return AppBar(
      title: const Text(
        'Edit Profile',
        style: kSFCaption,
      ),
      centerTitle: true,
      leading: TextButton(
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            FontAwesomeIcons.chevronLeft,
            color: kDarkBlue,
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
              style: kSFCaption,
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
