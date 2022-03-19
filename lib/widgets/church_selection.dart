import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/church_model.dart';

import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/church_tile.dart';
import 'package:cop_belgium/widgets/textfield.dart';
import 'package:flutter/material.dart';

class ChurchSelectionScreen extends StatefulWidget {
  final Function(ChurchModel?)? onTap;
  const ChurchSelectionScreen({Key? key, this.onTap}) : super(key: key);

  @override
  _ChurchSelectionScreenState createState() => _ChurchSelectionScreenState();
}

class _ChurchSelectionScreenState extends State<ChurchSelectionScreen> {
  ChurchModel? selectedChurch;

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
                    return const Center(child: kCircularProgressIndicator);
                  }

                  List<ChurchModel>? churches = data?.docs.map((map) {
                    return ChurchModel.fromMap(map: map.data());
                  }).toList();

                  if (churches!.isEmpty) {
                    return const Text('No result found', style: kSFBody);
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ChurchTile(
                        church: churches[index],
                        onTap: () async {
                          selectedChurch = churches[index];

                          widget.onTap!(selectedChurch);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: kContentSpacing12,
                    ),
                    itemCount: churches.length,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
