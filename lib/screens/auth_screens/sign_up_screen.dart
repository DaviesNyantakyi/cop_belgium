import 'package:cop_belgium/providers/signup_provider.dart';
import 'package:cop_belgium/screens/auth_screens/date_gender_view.dart';
import 'package:cop_belgium/screens/auth_screens/email_name_view.dart';
import 'package:cop_belgium/screens/auth_screens/password_view.dart';
import 'package:cop_belgium/screens/image_picker_screen.dart';
import 'package:cop_belgium/widgets/church_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static String signUpScreen = 'signUpScreen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  String? nameErrorText;

  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<PageController>.value(
              value: pageController,
            ),
            ChangeNotifierProvider<SignUpProvider>.value(
              value: Provider.of<SignUpProvider>(context, listen: false),
            ),
          ],
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: const [
              EmailNameView(),
              PasswordView(),
              DateGenderView(),
              ImagePickerScreen(),
              ChurchSelectorScreen()
            ],
          ),
        ),
      ),
    );
  }
}
