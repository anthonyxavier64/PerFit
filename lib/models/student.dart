import 'package:flutter/material.dart';

class Student with ChangeNotifier {
  final String name;
  final String school;
  final String course;
  final String skillsets;
  final int year;
  final String profileURL;
  final int age;
  final String personalStatement;
  final String resumeURL;
  bool gaveOffer;

  Student(
      {this.course,
      this.name,
      this.profileURL,
      this.school,
      this.skillsets,
      this.year,
      this.age,
      this.personalStatement,
      this.gaveOffer,
      this.resumeURL});

  void toggleOffer() {
    gaveOffer = !gaveOffer;
    notifyListeners();
  }
}
