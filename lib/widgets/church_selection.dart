import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/church_model.dart';
import 'package:cop_belgium/providers/signup_provider.dart';
import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/church_tile.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class ChurchSelectionScreen extends StatefulWidget {
  const ChurchSelectionScreen({Key? key}) : super(key: key);

  @override
  _ChurchSelectionScreenState createState() => _ChurchSelectionScreenState();
}

class _ChurchSelectionScreenState extends State<ChurchSelectionScreen> {
  // Login for adding search index
  // final churchName =
  //     churches[index].churchName.split('');

  // List<String> searchIndex = [];

  // String newWord = '';
  // for (var i = 0; i < churchName.length; i++) {
  //   newWord = newWord + churchName[i];

  //   searchIndex.add(newWord.toLowerCase());
  // }

  // await FirebaseFirestore.instance
  //     .collection('churches')
  //     .doc(churches[index].id)
  //     .update({'searchIndex': searchIndex});
  Future<void> onSubmit() async {
    FocusScope.of(context).unfocus();
    try {
      final hasConnection = await ConnectionChecker().checkConnection();

      if (hasConnection) {
        final signUpProvider =
            Provider.of<SignUpProvider>(context, listen: false);

        EasyLoading.show();
        await signUpProvider.signUp();

        Navigator.of(context)
          ..pop()
          ..pop();
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
  }

  TextEditingController searchContlr = TextEditingController();

  void searchChanges() {
    searchContlr.addListener(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    searchChanges();
    super.initState();
  }

  @override
  void dispose() {
    searchContlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _backButton(context: context),
        title: _buildHeaderText(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextFormField(
                controller: searchContlr,
                hintText: 'Search',
                maxLines: 1,
              ),
              const SizedBox(height: kContentSpacing32),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: searchContlr.text.isEmpty
                    ? FirebaseFirestore.instance
                        .collection('churches')
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('churches')
                        .where('searchIndex',
                            arrayContains: searchContlr.text.toLowerCase())
                        .snapshots(),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: kProgressIndicator);
                  }
                  List<Church>? churches = data?.docs.map((map) {
                    return Church.fromMap(map.data());
                  }).toList();

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ChurchTile(
                        thumbnail: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(churches![index].image),
                            ),
                          ),
                        ),
                        title: churches[index].churchName,
                        address:
                            '${churches[index].street} ${churches[index].streetNumber} - ${churches[index].postCode}, ${churches[index].city}',
                        onTap: onSubmit,
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: kContentSpacing12,
                    ),
                    itemCount: churches?.length ?? 0,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return const Text(
      'Select your church',
      style: kSFHeadLine3,
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
        Navigator.pop(context);
      },
    );
  }
}
