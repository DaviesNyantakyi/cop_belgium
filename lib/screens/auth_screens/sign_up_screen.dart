import 'package:cop_belgium/providers/signup_provider.dart';
import 'package:cop_belgium/screens/auth_screens/date_gender_view.dart';
import 'package:cop_belgium/screens/auth_screens/email_name_view.dart';
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
  PageController pageController = PageController(initialPage: 0);

  late final SignUpProvider signUpProvider;

  @override
  void initState() {
    signUpProvider = Provider.of<SignUpProvider>(context, listen: false);

    Provider.of<SignUpProvider>(context, listen: false).close();
    super.initState();
  }

  @override
  void dispose() {
    signUpProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(builder: (context, signUpProvider, _) {
      return Scaffold(
        body: SafeArea(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider<PageController>.value(
                value: pageController,
              ),
              ChangeNotifierProvider<SignUpProvider>.value(
                value: signUpProvider,
              ),
            ],
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: const [
                EmailNamePasswordView(),
                DateGenderView(),
                ImagePickerScreen(),
                ChurchSelectorScreen()
              ],
            ),
          ),
        ),
      );
    });
  }
}
