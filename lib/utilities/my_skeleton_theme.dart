import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class MySkeletonTheme extends StatelessWidget {
  final Widget child;
  const MySkeletonTheme({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonTheme(
      shimmerGradient: const LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xffF9F9FB),
          Color(0xffE6E8EB),
        ],
        stops: [
          0.1,
          0.9,
        ],
      ),
      child: child,
    );
  }
}
