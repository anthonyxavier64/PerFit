import 'package:flutter/material.dart';

import '../models/company.dart';

class CompaniesList with ChangeNotifier {
  List<Company> LIST_COMPANIES = [
    Company(
      id: 'abc',
      name: 'ABC Company',
      logoURL: 'assets/images/company_abc.png',
      founderName: 'Anthony Poh',
      industry: 'Architecture',
      joinedDate: '26/02/2020',
      isFavourite: false,
      tempJob: {
        'title': 'Architectural Designer Intern',
        'duration': 'June 2021 - December 2021',
        'skillsets': 'Basic architectural design skills, Photoshop'
      },
      jobList: null,
    ),
    Company(
        id: 'apple',
        name: 'Appol',
        logoURL: 'assets/images/company_apple.png',
        founderName: 'Xavier Poh',
        industry: 'Marketing',
        joinedDate: '21/02/2020',
        isFavourite: false,
        tempJob: {
          'title': 'Marketer',
          'duration': 'May 2021 - August 2021',
          'skillsets': 'Fruit tasting ability, Good communication skills'
        },
        jobList: null),
    Company(
        id: 'melon',
        name: 'BeatAPPOL',
        logoURL: 'assets/images/company_melon.png',
        founderName: 'Anthony Xavier',
        industry: 'Banking & Finance',
        joinedDate: '02/02/2020',
        location: '290 Orchard Rd, Singapore 238859',
        isFavourite: false,
        tempJob: {
          'title': 'Software Engineer Intern',
          'duration': 'July 2020 - December 2020',
          'skillsets': 'Flutter, Javascript, Java, Web Development'
        },
        jobList: null),
    Company(
        id: 'pear',
        name: 'PearWithMe',
        logoURL: 'assets/images/company_pear.png',
        founderName: 'Kang Su Min',
        industry: 'Civil Engineering',
        joinedDate: '21/08/2020',
        isFavourite: false,
        tempJob: {
          'title': 'Software Engineer Intern',
          'duration': 'March 2021 - December 2021',
          'skillsets': 'HTML, CSS, Java, Web Development'
        },
        jobList: null),
    Company(
        id: 'orange',
        name: 'AnnoyingOrange',
        logoURL: 'assets/images/company_orange.png',
        founderName: 'Ming Kang',
        industry: 'Fishing',
        joinedDate: '06/03/2020',
        isFavourite: false,
        tempJob: {
          'title': 'Annoying Intern',
          'duration': 'November 2051 - December 2051',
          'skillsets': 'Napping, Lazing, Big appeitite'
        },
        jobList: null),
  ];

  Company findById(String id) {
    return LIST_COMPANIES.firstWhere((company) => company.id == id);
  }

  List<Company> get favouriteCompanies {
    return LIST_COMPANIES.where((company) => company.isFavourite).toList();
  }

  List<Company> get offeredCompanies {
    return [...LIST_COMPANIES];
  }

  List<Company> get getCompanies {
    return [...LIST_COMPANIES];
  }

  void updateList() {
    notifyListeners();
  }

  //List<Company>
}
