import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/providers/image_picker_provider.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/easy_loading.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  Future<void> submit() async {
    try {
      bool hasConnection = await ConnectionChecker().checkConnection();
      if (hasConnection) {
        await EaslyLoadingIndicator.dismissLoading();

        await Provider.of<PageController>(context, listen: false).nextPage(
          duration: kPagViewDuration,
          curve: kPagViewCurve,
        );
      } else {
        throw ConnectionChecker.connectionException;
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      kshowSnackbar(
        type: SnackBarType.error,
        context: context,
        text: e.message!,
      );
    } catch (e) {
      debugPrint(e.toString());
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
      child: Consumer<ImagePickerProvider>(
          builder: (context, imagePickerProvider, _) {
        return Scaffold(
          appBar: _backButton(context: context),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: kBodyPadding, vertical: kBodyPadding),
              child: Column(
                children: [
                  const Text('Add profile image', style: kSFHeadLine2),
                  const SizedBox(height: 32),
                  _buildImage(imagePickerProvider: imagePickerProvider),
                  const SizedBox(height: kContentSpacing32),
                  _buildContinueButton(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  dynamic _backButton({required BuildContext context}) {
    return AppBar(
      leading: TextButton(
        style: kTextButtonStyle,
        child: const Icon(
          Icons.chevron_left,
          color: kBlack,
          size: 40,
        ),
        onPressed: () async {
          await Provider.of<PageController>(context, listen: false)
              .previousPage(
            duration: kPagViewDuration,
            curve: kPagViewCurve,
          );
        },
      ),
    );
  }

  Widget _buildImage({
    required ImagePickerProvider imagePickerProvider,
  }) {
    if (imagePickerProvider.selectedImage?.path != null) {
      return CircleAvatar(
        radius: 90,
        backgroundImage: Image.file(
          imagePickerProvider.selectedImage!,
          fit: BoxFit.cover,
        ).image,
        backgroundColor: kBlueLight,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          child: TextButton(
            onPressed: () async {
              await imagePickerProvider.showBottomSheet(context: context);
            },
            style: kTextButtonStyle,
            child: Container(),
          ),
        ),
      );
    }
    return CircleAvatar(
      radius: 90,
      backgroundColor: kBlueLight,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        child: TextButton(
          onPressed: () async {
            await imagePickerProvider.showBottomSheet(context: context);
          },
          style: kTextButtonStyle,
          child: const Center(
            child: Icon(Icons.photo_camera_outlined, color: kBlack),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Buttons.buildButton(
      context: context,
      color: kBlue,
      width: double.infinity,
      btnText: 'Continue',
      onPressed: submit,
    );
  }
}
