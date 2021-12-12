import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

class TestimoniesScreen extends StatelessWidget {
  static String testimoniesScreen = 'testimoniesScreen';
  const TestimoniesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(onTap: () {
        Navigator.pop(context);
      }),
      body: const SafeArea(
        child: Center(
          child: Text('Tesitmonies Screen'),
        ),
      ),
    );
  }
}

PreferredSizeWidget _buildAppbar({VoidCallback? onTap}) {
  return AppBar(
    leading: Container(
      margin: const EdgeInsets.symmetric(horizontal: kAppbarPadding),
      child: InkWell(
        splashColor: kBlueLight,
        child: Image.asset('assets/images/icons/arrow_left_icon.png'),
        onTap: onTap,
      ),
    ),
  );
}
