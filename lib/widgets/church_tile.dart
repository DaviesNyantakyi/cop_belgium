import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

class ChurchTile extends StatelessWidget {
  const ChurchTile({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.address,
    required this.onTap,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 120,
              width: 140,
              child: thumbnail,
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: kSFBodyBold,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    Text(
                      address,
                      style: kSFBody2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
