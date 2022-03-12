import 'package:cop_belgium/providers/image_picker_provider.dart';
import 'package:cop_belgium/screens/churches/church_detail_screen.dart';
import 'package:cop_belgium/screens/churches/create_church_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/church_selection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChurchesScreen extends StatelessWidget {
  const ChurchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final imagePickerProvider =
              Provider.of<ImagePickerProvider>(context, listen: false);
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider<ImagePickerProvider>.value(
                    value: imagePickerProvider,
                  ),
                ],
                child: const CreateChurchScreen(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: kBackButton(context: context),
        title: const Text(
          'Churches',
          style: kSFHeadLine3,
        ),
      ),
      body: ChurchSelectionScreen(
        onTap: (church) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ChurchDetailScreen(
                church: church!,
              ),
            ),
          );
        },
      ),
    );
  }
}
