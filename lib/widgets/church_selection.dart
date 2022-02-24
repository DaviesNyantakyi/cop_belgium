import 'package:cop_belgium/providers/signup_provider.dart';
import 'package:cop_belgium/screens/all_screens.dart';
import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/church_tile.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class ChurchSelectionScreen extends StatefulWidget {
  const ChurchSelectionScreen({Key? key}) : super(key: key);

  @override
  State<ChurchSelectionScreen> createState() => _ChurchSelectionScreenState();
}

class _ChurchSelectionScreenState extends State<ChurchSelectionScreen> {
  PageController pageController = PageController(initialPage: 0);

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
                CitySelectionView(),
                ChurchSelectionView(),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class CitySelectionView extends StatefulWidget {
  const CitySelectionView({Key? key}) : super(key: key);

  @override
  _CitySelectionViewState createState() => _CitySelectionViewState();
}

class _CitySelectionViewState extends State<CitySelectionView> {
  Future<void> onSubmit() async {
    FocusScope.of(context).unfocus();
    // final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    // final bool? validEmail = signUpProvider.emailKey.currentState?.validate();
    // final bool? validFirstName =
    //     signUpProvider.firstNameKey.currentState?.validate();
    // final bool? validLastName =
    //     signUpProvider.lastNameKey.currentState?.validate();
    // final bool? validPasswordField =
    //     signUpProvider.passwordKey.currentState?.validate();

    await Provider.of<PageController>(context, listen: false).nextPage(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutExpo,
    );
  }

  String church = 'Turnhout';

  List<String> churches = [
    'Antwerp',
    'Turnhout',
    'Ghent',
    'Brussels',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: kBackButton(context: context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderText(),
              const SizedBox(height: 24),
              ListView.builder(
                shrinkWrap: true,
                itemCount: churches.length,
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    activeColor: kBlue,
                    contentPadding: EdgeInsets.zero,
                    title: Text(churches[index]),
                    value: churches[index],
                    groupValue: church,
                    onChanged: (value) {
                      church = value!;
                      setState(() {});
                    },
                  );
                },
              ),
              const SizedBox(height: kContentSpacing32),
              _buildContinueButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return const Text(
      'Select your city',
      style: kSFHeadLine2,
    );
  }

  Widget _buildContinueButton() {
    return Buttons.buildButton(
      context: context,
      btnText: 'Continue',
      width: double.infinity,
      onPressed: onSubmit,
    );
  }
}

class ChurchSelectionView extends StatefulWidget {
  const ChurchSelectionView({Key? key}) : super(key: key);

  @override
  _ChurchSelectionViewState createState() => _ChurchSelectionViewState();
}

class _ChurchSelectionViewState extends State<ChurchSelectionView> {
  Future<void> onSubmit() async {
    FocusScope.of(context).unfocus();
    try {
      final hasConnection = await ConnectionChecker().checkConnection();

      if (hasConnection) {
        final signUpProvider =
            Provider.of<SignUpProvider>(context, listen: false);

        EasyLoading.show();
        await signUpProvider.signUp();

        Navigator.pop(context);
      } else {
        throw ConnectionChecker.connectionException;
      }
    } on FirebaseException catch (e) {
      kshowSnackbar(
        context: context,
        errorType: 'error',
        text: e.message!,
      );
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EasyLoading.dismiss();
    }

    await Provider.of<PageController>(context, listen: false).nextPage(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutExpo,
    );
  }

  String church = 'turnhout piwc';

  List<String> churches = [
    'turnhout central',
    'piwc turnhout',
    'gent central',
    'gent piwc',
    'turnhout central',
    'piwc turnhout',
    'gent central',
    'gent piwc',
    'turnhout central',
    'piwc turnhout',
    'gent central',
    'gent piwc',
    'turnhout central',
    'piwc turnhout',
    'gent central',
    'gent piwc',
    'turnhout central',
    'piwc turnhout',
    'gent central',
    'gent piwc',
    'turnhout central',
    'piwc turnhout',
    'gent central',
    'gent piwc',
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Provider.of<PageController>(context, listen: false).previousPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutExpo,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: _backButton(context: context),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(kBodyPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderText(),
                const SizedBox(height: kContentSpacing32),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  shrinkWrap: true,
                  itemCount: churches.length,
                  itemBuilder: (context, index) {
                    return ChurchTile(
                      thumbnail: Container(
                        height: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1549643276-fdf2fab574f5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80'),
                          ),
                        ),
                      ),
                      title: churches[index],
                      user: 'Patriottenstraat 94, 2300 Turnhout',
                      onTap: onSubmit,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return const Text(
      'Select your church',
      style: kSFHeadLine2,
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
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutExpo,
        );
      },
    );
  }
}
