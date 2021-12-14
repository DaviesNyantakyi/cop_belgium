import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String _profileImage =
    'https://images.unsplash.com/photo-1584473457409-ae5c91d7d8b1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YmxhY2slMjBnaXJsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60';

class EditProfileScreen extends StatefulWidget {
  static String editProfileScreen = 'editProfileScreen';
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isChecked = false;

  String? firstName;
  String? lastName;
  String? email;

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
                  backgroundImage: NetworkImage(_profileImage),
                  radius: 50,
                  backgroundColor: kBlueDark,
                ),
                MyTextField.buildTF(
                  label: 'First Name',
                  hintText: 'John',
                  obscureText: false,
                  onChanged: (value) {},
                ),
                const SizedBox(height: kTextFieldSpacing),
                MyTextField.buildTF(
                  label: 'Last Name',
                  hintText: 'John',
                  obscureText: false,
                  onChanged: (value) {},
                ),
                const SizedBox(height: kTextFieldSpacing),
                MyTextField.buildTF(
                  label: 'Email',
                  hintText: 'John',
                  obscureText: false,
                  onChanged: (value) {},
                ),
                const SizedBox(height: kTextFieldSpacing),
                _buildGenderSelector(),
                const SizedBox(height: 21),
                _buildLocationSelector(),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildBt(
                      btText: 'Delete Account',
                      textColor: kRed,
                      backgroundColor: kRedLight,
                      onPressed: () {},
                    ),
                    _buildBt(
                      btText: 'Send Password Recovery',
                      textColor: kGreen,
                      backgroundColor: kGreen1Light,
                      onPressed: () {},
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
        Container(
          height: 45,
          width: 195,
          color: kBlueDark,
          child: Row(
            children: [],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSelector() {
    return TextButton(
      onPressed: () {},
      style: kTextButtonStyle,
      child: Container(
        decoration: const BoxDecoration(
          color: kBlueLight,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        height: 58,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Turnhout',
                style: kSFBody,
              ),
            ),
            const Expanded(child: SizedBox()),
            Container(
              alignment: Alignment.centerRight,
              child: _buildPopupMenu(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPopupMenu() {
    return PopupMenuButton<Locations>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      elevation: 4,
      icon: const Icon(
        FontAwesomeIcons.chevronDown,
        size: 20,
        color: kBlueDark,
      ),
      onSelected: (Locations result) {},
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<Locations>>[
          const PopupMenuItem<Locations>(
            value: Locations.turnhout,
            child: Text('Turnhout'),
          ),
        ];
      },
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
