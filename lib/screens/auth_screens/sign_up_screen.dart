import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/church_model.dart';
import 'package:cop_belgium/providers/signup_provider.dart';
import 'package:cop_belgium/screens/auth_screens/date_gender_view.dart';
import 'package:cop_belgium/screens/auth_screens/email_name_view.dart';
import 'package:cop_belgium/screens/image_picker_screen.dart';
import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/church_selection.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
                _ChurchSelection()
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _ChurchSelection extends StatefulWidget {
  const _ChurchSelection({Key? key}) : super(key: key);

  @override
  State<_ChurchSelection> createState() => _ChurchSelectionState();
}

class _ChurchSelectionState extends State<_ChurchSelection> {
  Future<void> onSubmit({required Church church}) async {
    FocusScope.of(context).unfocus();
    try {
      final hasConnection = await ConnectionChecker().checkConnection();

      if (hasConnection) {
        final signUpProvider =
            Provider.of<SignUpProvider>(context, listen: false);

        EasyLoading.show();
        signUpProvider.setChurch(church: church.id);

        //TODO: set selected image before sign up

        // signUpProvider.setSelectedImage(
        //   image: imagePickerProvider.selectedImage,
        // );
        await signUpProvider.signUp();

        Navigator.pop(context);
      } else {
        throw ConnectionChecker.connectionException;
      }
    } on FirebaseException catch (e) {
      kshowSnackbar(
        context: context,
        type: SnackBarType.error,
        text: e.message!,
      );

      if (e.code.contains('email-already-in-use') ||
          e.code.contains('invalid-email')) {
        Provider.of<PageController>(context, listen: false).animateToPage(
          0,
          duration: kPagViewDuration,
          curve: kPagViewCurve,
        );
      }

      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Provider.of<PageController>(context, listen: false).previousPage(
          duration: kPagViewDuration,
          curve: kPagViewCurve,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: _backButton(context: context),
          title: const Text('Select your church', style: kSFHeadLine3),
        ),
        body: ChurchSelectionScreen(onTap: (church) {
          if (church != null) {
            onSubmit(church: church);
          }
        }),
      ),
    );
  }

  dynamic _backButton({required BuildContext context}) {
    return TextButton(
      style: kTextButtonStyle,
      child: const Icon(
        Icons.chevron_left,
        color: kBlack,
        size: 40,
      ),
      onPressed: () async {
        await Provider.of<PageController>(context, listen: false).previousPage(
          duration: kPagViewDuration,
          curve: kPagViewCurve,
        );
      },
    );
  }
}
