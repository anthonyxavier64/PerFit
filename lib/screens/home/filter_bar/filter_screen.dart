import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  static const routeName = './filterScreen';
  final bool isEmployer;
  final DocumentSnapshot currentUser;
  final bool notSignedIn;

  FilterScreen(this.isEmployer, this.currentUser, this.notSignedIn);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('filter'));
  }
}
