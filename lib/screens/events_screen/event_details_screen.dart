import 'package:cop_belgium/models/episodes_model.dart';
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
  static const CameraPosition initialPostion = CameraPosition(
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
                    _buildEventInfo(),
                    const SizedBox(height: 25),
                    _buildDescription(),
                    const SizedBox(height: 18),
                    _buildLocationMap(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//TODO: add marker for laction
  Widget _buildLocationMap() {
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
              markers: {
                const Marker(
                  markerId: MarkerId('turnhout'),
                  position: LatLng(51.31830821507976, 4.939745926843822),
                ),
              },
              scrollGesturesEnabled: true,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
              initialCameraPosition: initialPostion,
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

  Widget _buildCalendarInfo() {
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
            FontAwesomeIcons.calendar,
            color: kBlueDark,
            size: 24,
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '20 May 2021',
                style: kSFCaption,
              ),
              Text(
                '8:30 AM',
                style: kSFCaption,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationInfo() {
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
            child: Image.asset(
              'assets/images/logos/zoom.png',
              width: 24,
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'Zoom',
            style: kSFBody,
          )
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
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
        const Flexible(
          child: Text(
            'Patriottenstraat 94, 2300 Turnhout',
            style: kSFCaption,
          ),
        ),
      ],
    );
  }

  Widget _buildEventInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCalendarInfo(),
              const SizedBox(height: 18),
              _buildLocationInfo(),
            ],
          ),
        ),
        Flexible(
          child: _buildReminderBtn(),
        ),
      ],
    );
  }

  Widget _buildReminderBtn() {
    return Buttons.buildBtn(
      context: context,
      btnText: 'Add to Calendar',
      onPressed: () {},
      height: 25,
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
            'About Event',
            style: kSFBodyBold,
          ),
        ),
        const SizedBox(height: 7),
        TextButton(
          style: kTextButtonStyle,
          onPressed: () {
            _showBottomSheet(
              context: context,
              title: _title,
              description: _description,
            );
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
