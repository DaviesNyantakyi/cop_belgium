import 'package:flutter/material.dart';

class FastingCard extends StatelessWidget {
  final String typeFast;
  final int duration;
  final VoidCallback? onPressed;
  final Color backgroundColor;

  const FastingCard({
    Key? key,
    required this.typeFast,
    required this.duration,
    required this.onPressed,
    required this.backgroundColor,
  }) : super(key: key);

// weeding window
// 18:8
// duration
  @override
  Widget build(BuildContext context) {
    Widget _getFeedingWindow() {
      int hour = 24;
      // shows the feeding window format (10:14) and the fasting type
      //if the duration is smaller then 24 hours

      if (duration < hour) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$duration:${hour - duration}', // feeding window
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white54,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              typeFast,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      } else {
        return Text(
          typeFast,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white54,
            fontWeight: FontWeight.bold,
          ),
        );
      }
    }

    _buildBody() {
      if (typeFast.toLowerCase() != 'custom fast') {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getFeedingWindow(),
            Text(
              '$duration',
              style: const TextStyle(
                fontSize: 48,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              'Hours',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white54,
              ),
            ),
          ],
        );
      } else {
        return Column(
          children: const [
            Text(
              'Custom Fast',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white54,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Icon(
                Icons.add,
                size: 40,
                color: Colors.white,
              ),
            ),
          ],
        );
      }
    }

    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 220,
        width: 190,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: _buildBody(),
        ),
      ),
    );
  }
}
