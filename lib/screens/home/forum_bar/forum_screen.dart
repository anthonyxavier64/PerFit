import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ForumScreen extends StatelessWidget {
  static const routeName = './forumScreen';
  final bool isEmployer;
  final DocumentSnapshot currentUser;
  final bool notSignedIn;

  ForumScreen(this.isEmployer, this.currentUser, this.notSignedIn);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('forum'),
    );
  }
}
