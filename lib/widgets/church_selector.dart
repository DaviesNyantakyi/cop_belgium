import 'package:cop_belgium/screens/all_screens.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        child: PageView(
          controller: pageController,
          children: const [
            DistrictSelectorView(),
            CitySelectorView(),
            AssemblySelectorView()
          ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select your district.',
                style: kSFHeadLine2,
              ),
              const SizedBox(height: kButtonSpacing),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select your city.',
                style: kSFHeadLine2,
              ),
              const SizedBox(height: kButtonSpacing),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select your Assembly.',
                style: kSFHeadLine2,
              ),
              const SizedBox(height: kButtonSpacing),
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
            ],
          ),
        ),
      ),
    );
  }
}
