import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/testimony_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/testimony_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../all_screens.dart';

class UserTestimoniesView extends StatefulWidget {
  static String userTestimoniesView = 'userTestimoniesView';

  const UserTestimoniesView({Key? key}) : super(key: key);

  @override
  State<UserTestimoniesView> createState() => _UserTestimoniesViewState();
}

class _UserTestimoniesViewState extends State<UserTestimoniesView> {
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
