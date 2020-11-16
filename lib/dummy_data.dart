import 'package:perfit_app/models/company.dart';
import './models/student.dart';

class DummyData {
  final List<int> _yearOfStudy = [1, 2, 3, 4, 5];

  final List<String> _genders = ['Male', 'Female'];

  final Map<String, List<String>> _specialisations = {
    'Information Systems': [
      'None',
      'Fintech',
      'Digital Innovation',
      'Ecommerce',
    ],
    'Computer Science': [
      'None',
      'AI',
      'Machine Learning',
      'Game development',
    ],
    'Economics': [
      'None',
      'Macro',
      'Micro',
    ],
    'Communications and News Media': [
      'None',
      'Social Media',
      'Newspaper',
    ],
    'Environmental Engineering': [
      'None',
    ],
    'Chemical Engineering': [
      'None',
    ],
    'Data Science': [
      'None',
    ],
    'Mathematics': [
      'None',
    ],
    'Accountancy': [
      'None',
    ],
  };

  final Map<String, List<String>> _courses = {
    'Computing': ['Information Systems', 'Computer Science'],
    'FASS': ['Economics', 'Communications and News Media'],
    'Engineering': ['Environmental Engineering', 'Chemical Engineering'],
    'Science': ['Data Science', 'Mathematics'],
    'Business': ['Accountancy'],
  };

  final List<String> _months = [
    'Jan',
    'Feb',
    'March',
    'April',
    'May',
    'June',
    'July',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  final List<String> _schools = [
    'NUS',
    'NTU',
    'SIM',
    'SMU',
    'SP',
    'TP',
    'RP',
  ];

  final Map<String, List<String>> _faculties = {
    'NUS': [
      'Computing',
      'FASS',
      'Engineering',
      'Science',
      'Business',
    ],
    'NTU': [
      'Computing',
      'FASS',
      'Engineering',
      'Science',
      'Business',
    ],
    'SIM': [
      'Computing',
      'FASS',
      'Engineering',
      'Science',
      'Business',
    ],
    'SMU': [
      'Computing',
      'FASS',
      'Engineering',
      'Science',
      'Business',
    ],
    'SP': [
      'Computing',
      'FASS',
      'Engineering',
      'Science',
      'Business',
    ],
    'TP': [
      'Computing',
      'FASS',
      'Engineering',
      'Science',
      'Business',
    ],
    'RP': [
      'Computing',
      'FASS',
    ],
  };

  final List<String> _industries = [
    'Technology',
    'Business',
    'Arts',
    'Science',
    'Engineering',
  ];

  List<int> get yearOfStudy {
    return _yearOfStudy;
  }

  List<String> get genders {
    return _genders;
  }

  Map<String, List<String>> get specialisations {
    return _specialisations;
  }

  Map<String, List<String>> get courses {
    return _courses;
  }

  List<String> get months {
    return _months;
  }

  List<String> get schools {
    return _schools;
  }

  Map<String, List<String>> get faculties {
    return _faculties;
  }

  List<String> get industries {
    return _industries;
  }

  static List<Company> DUMMY_COMPANIES = [
    Company(
      id: 'abc',
      name: 'ABC Company',
      logoURL: 'assets/images/company_abc.png',
      founderName: 'Anthony Poh',
      industry: 'Architecture',
      location: '290 Orchard Rd, Singapore 238859',
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
        location: '290 Orchard Rd, Singapore 238859',
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
        isFavourite: true,
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
        location: '290 Orchard Rd, Singapore 238859',
        isFavourite: true,
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
        location: '290 Orchard Rd, Singapore 238859',
        isFavourite: true,
        tempJob: {
          'title': 'Annoying Intern',
          'duration': 'November 2051 - December 2051',
          'skillsets': 'Napping, Lazing, Big appeitite'
        },
        jobList: null),
  ];

  static List<Student> DUMMY_STUDENTS = [
    Student(
      name: 'Popo Pipo',
      school: 'NUS',
      course: 'COM',
      year: 1,
      age: 22,
      gaveOffer: false,
      profileURL: 'assets/images/student_1.jpg',
      personalStatement:
          'Now seven world think timed while her. Spoil large oh he rooms on since an. Am up unwilling eagerness perceived incommode. Are not windows set luckily musical hundred can. Collecting if sympathize middletons be of of reasonably. Horrible so kindness at thoughts exercise no weddings subjects. The mrs gay removed towards journey chapter females offered not. Led distrusts otherwise who may newspaper but. Last he dull am none he mile hold as. ',
      resumeURL: 'assets/images/resume.jpg',
    ),
    Student(
      name: 'Thomas Train',
      school: 'NTU',
      course: 'BIZ',
      year: 2,
      age: 7,
      gaveOffer: false,
      profileURL: 'assets/images/student_2.jpeg',
      resumeURL: 'assets/images/resume.jpg',
      personalStatement:
          'Now seven world think timed while her. Spoil large oh he rooms on since an. Am up unwilling eagerness perceived incommode. Are not windows set luckily musical hundred can. Collecting if sympathize middletons be of of reasonably. Horrible so kindness at thoughts exercise no weddings subjects. The mrs gay removed towards journey chapter females offered not. Led distrusts otherwise who may newspaper but. Last he dull am none he mile hold as. ',
    ),
    Student(
      name: 'Kang Su Min',
      school: 'NUS',
      course: 'SCI',
      year: 3,
      age: 13,
      gaveOffer: true,
      profileURL: 'assets/images/student_3.jpg',
      resumeURL: 'assets/images/resume.jpg',
      personalStatement:
          'Now seven world think timed while her. Spoil large oh he rooms on since an. Am up unwilling eagerness perceived incommode. Are not windows set luckily musical hundred can. Collecting if sympathize middletons be of of reasonably. Horrible so kindness at thoughts exercise no weddings subjects. The mrs gay removed towards journey chapter females offered not. Led distrusts otherwise who may newspaper but. Last he dull am none he mile hold as. ',
    ),
    Student(
      name: 'Homer Simpson',
      school: 'NUS',
      course: 'ARTS',
      year: 1,
      age: 45,
      gaveOffer: true,
      profileURL: 'assets/images/student_4.jpg',
      resumeURL: 'assets/images/resume.jpg',
      personalStatement:
          'Now seven world think timed while her. Spoil large oh he rooms on since an. Am up unwilling eagerness perceived incommode. Are not windows set luckily musical hundred can. Collecting if sympathize middletons be of of reasonably. Horrible so kindness at thoughts exercise no weddings subjects. The mrs gay removed towards journey chapter females offered not. Led distrusts otherwise who may newspaper but. Last he dull am none he mile hold as.',
    ),
    Student(
      name: 'Donald Duck',
      school: 'Ngee Ann Polytechnic',
      course: 'BIZ',
      year: 4,
      age: 100,
      gaveOffer: true,
      profileURL: 'assets/images/student_5.jpeg',
      resumeURL: 'assets/images/resume.jpg',
      personalStatement:
          'Now seven world think timed while her. Spoil large oh he rooms on since an. Am up unwilling eagerness perceived incommode. Are not windows set luckily musical hundred can. Collecting if sympathize middletons be of of reasonably. Horrible so kindness at thoughts exercise no weddings subjects. The mrs gay removed towards journey chapter females offered not. Led distrusts otherwise who may newspaper but. Last he dull am none he mile hold as. ',
    ),
  ];
}
