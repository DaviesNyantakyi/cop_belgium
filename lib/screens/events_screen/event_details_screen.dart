import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String _description =
    'Laborum ut non adipisicing labore eiusmod enim ex fugiat Lorem esse ea do. Pariatur officia nisi nulla enim non nostrud minim cillum voluptate ex mollit. Elit dolor non adipisicing nulla in elit ipsum magna labore ea aliqua minim. Amet excepteur ullamco aliqua reprehenderit in sint. Minim excepteur commodo anim incididunt officia anim nisi id Lorem excepteur et in quis ea.';

String _title = 'Laborum ut non adipisicing labore eiusmod enim ex ';

class EventDetailScreen extends StatefulWidget {
  final String eventType;
  static String podcastDetailScreen = 'podcastDetailScreen';
  const EventDetailScreen({Key? key, required this.eventType})
      : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(51.322182921264194, 4.937284434846798),
    zoom: 10,
  );

  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mapController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: Padding(
        padding: const EdgeInsets.only(bottom: kBodyPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildImage(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kBodyPadding)
                    .copyWith(
                  bottom: kBodyPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(),
                    const SizedBox(height: 20),
                    _buildAttendenceCount(),
                    const SizedBox(height: 25),
                    _buildCalendarDetails(
                      icon: FontAwesomeIcons.calendar,
                      date: '20 May 2021',
                      time: '8:30 AM',
                    ),
                    const SizedBox(height: 18),
                    _buildLocationDetails(),
                    const SizedBox(height: 18),
                    _buildDescription(),
                    const SizedBox(height: 18),
                    _buildLocation(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocation() {
    if (widget.eventType == 'online') {
      return Container();
    }
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Location',
            style: kSFBodyBold,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          height: 212,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: GoogleMap(
              scrollGesturesEnabled: true,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      child: const Text(
        'Lorem ipsum dolor sit',
        style: kSFHeadLine2,
      ),
    );
  }

  Widget _buildCalendarDetails({
    required IconData icon,
    required String date,
    required String time,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: kBlueDark.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Icon(
            icon,
            color: kBlueDark,
            size: 24,
          ),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: kSFBody,
            ),
            Text(
              time,
              style: kSFCaption,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationDetails() {
    if (widget.eventType == 'online') {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: kBlueDark.withOpacity(0.1),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/logos/zoom.png',
                  width: 30,
                ),
                const SizedBox(width: 6),
                const Text(
                  'Zoom',
                  style: kSFBodyBold,
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: kBlueDark.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: const Icon(
            FontAwesomeIcons.mapMarkerAlt,
            color: kBlueDark,
            size: 20,
          ),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Turnhout',
              style: kSFBody,
            ),
            Flexible(
              child: Text(
                'Korte',
                style: kSFCaption,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAttendenceCount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 65),
              alignment: Alignment.centerLeft,
              child: Stack(
                clipBehavior: Clip.none,
                children: const [
                  Positioned(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                      ),
                    ),
                  ),
                  Positioned(
                    left: 14,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
                      ),
                    ),
                  ),
                  Positioned(
                    left: 28,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                      ),
                    ),
                  ),
                  Positioned(
                    left: 42,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                      ),
                    ),
                  ),
                  Positioned(
                    left: 56,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              '+ 120 Interested',
              style: kSFBody,
            ),
          ],
        ),
        _buildAttendButtton(),
      ],
    );
  }

  Widget _buildAttendButtton() {
    if (widget.eventType == 'online') {
      return Flexible(
        child: Buttons.buildBtn(
          context: context,
          btnText: 'Join',
          onPressed: () {},
          height: 25,
          width: 91,
        ),
      );
    }
    return Flexible(
      child: Buttons.buildBtn(
        context: context,
        btnText: 'Add',
        onPressed: () {},
        height: 25,
        width: 91,
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: const BoxDecoration(
        color: kBlueDark,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            'https://images.unsplash.com/photo-1620982591827-5e003e8d26fb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80',
          ),
        ),
      ),
    );
  }

  Future<void> _showBottomSheet({
    required BuildContext context,
    required String title,
    required String description,
  }) {
    return showMyBottomSheet(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: kSFHeadLine2,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              description,
              style: kSFBody,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Details',
            style: kSFBodyBold,
          ),
        ),
        const SizedBox(height: 7),
        TextButton(
          style: kTextButtonStyle,
          onPressed: () {
            _showBottomSheet(
                context: context, title: _title, description: _description);
          },
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              _description,
              style: kSFBody,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: TextButton(
        child: const Icon(
          FontAwesomeIcons.chevronLeft,
          color: kBlueDark,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        style: kTextButtonStyle,
      ),
    );
  }
}
