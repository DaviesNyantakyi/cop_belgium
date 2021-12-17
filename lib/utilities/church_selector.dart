import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChurchSelctor {
  String? _selectedChurch;
  final List<String> _cities = ['Turnhout', 'Brussel', 'Gent', 'Antwerp'];

  ChurchSelctor();

  Widget buildChurchSelectorTile({
    required String? city, // the chosen city for updating the widget
    required Function(String?) onChanged,
    required BuildContext context,
  }) {
    return ListTile(
      tileColor: kBlueLight1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kButtonRadius),
        ),
      ),
      onTap: () async {
        // get the selected location back and pas it in onChanged
        _selectedChurch = await _showBottomSheet(context: context);
        onChanged(_selectedChurch);
      },
      leading: const Text(
        'Church Location',
        style: kSFBody,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            city ?? '',
            style: kSFBody,
          ),
          const SizedBox(width: 10),
          const Icon(
            FontAwesomeIcons.chevronRight,
            color: kDarkBlue,
          ),
        ],
      ),
    );
  }

  Future<String?> _showBottomSheet({required BuildContext context}) async {
    //Bottom sheet show the list of churches
    //The selected location gets passed back when the bottomSheet is closed
    return await showModalBottomSheet<String?>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: kBottomSheetHeight,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: _cities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    _cities[index],
                    style: kSFBody,
                  ),
                  onTap: () {
                    Navigator.pop(context, _cities[index]);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

// selected church

// List of churches to be used in the bottom nav
// when the user clickes on it the seleted church will be set to the property
