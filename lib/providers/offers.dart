import 'package:flutter/foundation.dart';

class OfferItem {
  /*final String id;
  final String name;
  final String imageURL;
  final String industry;
  final String school;
  
  final String course;
  final String founderName;
  final String joinedDate;
  */
  final bool isStudent;
  final String companyId;
  final String studentId;

  OfferItem({
    this.isStudent,
    this.companyId,
    this.studentId,
  });
}

class Offers with ChangeNotifier {
  Map<String, OfferItem> _offerListStudents = {};
  Map<String, OfferItem> _offerListCompanies = {};

  Map<String, OfferItem> get offerListCompanies {
    return {..._offerListCompanies};
  }

  Map<String, OfferItem> get offerListStudents {
    return {..._offerListStudents};
  }

  void addOfferStudent(String studentId, String name) {
    _offerListStudents.putIfAbsent(
        studentId,
        () => OfferItem(
              isStudent: true,
              studentId: studentId,
              companyId: 'nil',
            ));
    notifyListeners();
  }

  void cancelOfferStudent(String name) {
    _offerListStudents.remove(name);
    notifyListeners();
  }
}
