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

  // only validate when the signup button is pressed

  // Future<void> signUp() async {
  //   FocusScope.of(context).unfocus();
  //   EasyLoading.show();
  //   try {
  //     isLoading = true;

  //     bool isValid = validateForm();

  //     if (isValid) {
  //       // final user = CopUser(
  //       //   firstName: firstNameCntlr.text,
  //       //   lastName: lastNameCntlr.text,
  //       //   email: emailCntlr.text,
  //       //   birthDate: birthDate!,
  //       //   gender: genderCntlr.text,
  //       //   isAdmin: false,
  //       // );
  //       if (mounted) {
  //         setState(() {});
  //       }

  //       // await FireAuth()
  //       //     .signUpEmailPassword(user: user, password: passwordCntlr.text);
  //       // await EasyLoading.dismiss();

  //       Navigator.pop(context);

  //       await Navigator.push(
  //         context,
  //         CupertinoPageRoute(builder: (context) => const ImagePickerScreen()),
  //       );
  //     }

  //     if (mounted) {
  //       setState(() {});
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     await EasyLoading.dismiss();
  //     kshowSnackbar(
  //       context: context,
  //       errorType: 'error',
  //       text: e.message!,
  //     );
  //     debugPrint(e.toString());
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   } finally {
  //     isLoading = false;
  //     EasyLoading.dismiss();
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   }
  // }

  // bool validateForm() {
  //   nameErrorText = Validators.nameValidator(
  //     firstName: firstNameCntlr.text,
  //     lastName: lastNameCntlr.text,
  //   );
  //   // emailErrorText = Validators.emailValidator(
  //   //   email: emailCntlr.text,
  //   // );
  //   passwordErrorText = Validators.passwordTextValidator(
  //     password: passwordCntlr.text,
  //   );

  //   birthDateErrorText = Validators.birthdayValidator(date: birthDate);

  //   genderErrorText = Validators.genderValidator(gender: genderCntlr.text);

  //   if (nameErrorText == null &&
  //       // emailErrorText == null &&
  //       passwordErrorText == null &&
  //       birthDateErrorText == null &&
  //       genderErrorText == null) {
  //     return true;
  //   }
  //   return false;
  // }

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
