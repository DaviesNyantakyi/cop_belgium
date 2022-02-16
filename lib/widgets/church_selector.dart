import 'package:cop_belgium/screens/all_screens.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChurchSelectorScreen extends StatefulWidget {
  const ChurchSelectorScreen({Key? key}) : super(key: key);

  @override
  State<ChurchSelectorScreen> createState() => _ChurchSelectorScreenState();
}

class _ChurchSelectorScreenState extends State<ChurchSelectorScreen> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider<PageController>.value(
          value: pageController,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: const [
              DistrictSelectorView(),
              CitySelectorView(),
              AssemblySelectorView()
            ],
          ),
        ),
      ),
    );
  }
}

class DistrictSelectorView extends StatefulWidget {
  const DistrictSelectorView({Key? key}) : super(key: key);

  @override
  State<DistrictSelectorView> createState() => _DistrictSelectorViewState();
}

class _DistrictSelectorViewState extends State<DistrictSelectorView> {
  List<String> districts = ['Antwerp', 'Brussels', 'Ghent'];
  String? groupValue;

  Future<void> onSubmit() async {
    await Provider.of<PageController>(context, listen: false).nextPage(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutExpo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Select your district',
          style: kSFHeadLine3,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: districts.length,
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    activeColor: kBlue,
                    contentPadding: const EdgeInsets.all(0),
                    value: districts[index],
                    groupValue: groupValue,
                    onChanged: (value) async {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                    title: Text(districts[index], style: kSFBody),
                  );
                },
              ),
              const SizedBox(height: kButtonSpacing),
              Buttons.buildBtn(
                context: context,
                btnText: 'Continue',
                width: double.infinity,
                onPressed: onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CitySelectorView extends StatefulWidget {
  const CitySelectorView({Key? key}) : super(key: key);

  @override
  State<CitySelectorView> createState() => _CitySelectorViewState();
}

class _CitySelectorViewState extends State<CitySelectorView> {
  List<String> districts = ['Antwerp', 'Turnhout', 'Mol', 'Herentals'];
  String? groupValue;

  Future<void> onSubmit() async {
    await Provider.of<PageController>(context, listen: false).nextPage(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutExpo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Select your city',
          style: kSFHeadLine3,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: districts.length,
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    activeColor: kBlue,
                    contentPadding: const EdgeInsets.all(0),
                    value: districts[index],
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                    title: Text(districts[index], style: kSFBody),
                  );
                },
              ),
              const SizedBox(height: kButtonSpacing),
              Buttons.buildBtn(
                context: context,
                btnText: 'Continue',
                width: double.infinity,
                onPressed: onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AssemblySelectorView extends StatefulWidget {
  const AssemblySelectorView({Key? key}) : super(key: key);

  @override
  State<AssemblySelectorView> createState() => _AssemblySelectorViewState();
}

class _AssemblySelectorViewState extends State<AssemblySelectorView> {
  List<Map<String, dynamic>> districts = [
    {
      'church1': {
        'name': 'Turnhout Central & Piwc',
        'address': 'Patriottenstraat 94, 2300 Turnhout'
      }
    },
  ];
  Map<String, dynamic>? groupValue;

  Future<void> onSubmit() async {
    await Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const BottomNavSelectorPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Select your assembly',
          style: kSFHeadLine3,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: districts.length,
                itemBuilder: (context, index) {
                  return RadioListTile<Map<String, dynamic>>(
                    activeColor: kBlue,
                    contentPadding: const EdgeInsets.all(0),
                    value: districts[index],
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const BottomNavSelectorPage(),
                        ),
                      );
                    },
                    title: Text(
                      districts[index]['church1']['name'],
                      style: kSFBody,
                    ),
                    subtitle: Text(
                      districts[index]['church1']['address'],
                      style: kSFBody2,
                    ),
                  );
                },
              ),
              const SizedBox(height: kButtonSpacing),
              Buttons.buildBtn(
                context: context,
                btnText: 'Done',
                width: double.infinity,
                onPressed: onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
