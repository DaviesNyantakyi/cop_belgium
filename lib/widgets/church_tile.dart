import 'package:cop_belgium/models/church_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

import '../utilities/constant.dart';

//  '${churches[index].street} ${churches[index].streetNumber} - ${churches[index].postCode}, ${churches[index].city}',
class ChurchTile extends StatelessWidget {
  final VoidCallback onTap;
  final ChurchModel church;

  const ChurchTile({
    Key? key,
    required this.church,
    required this.onTap,
  }) : super(key: key);

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
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: kBlueLight,
                  image: church.imageURL != null
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(church.imageURL!),
                        )
                      : null,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      church.churchName,
                      style: kSFBodyBold,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    Text(
                      '${church.street} ${church.streetNumber} - ${church.postCode}, ${church.city}',
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
