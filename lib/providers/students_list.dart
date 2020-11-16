import 'package:flutter/material.dart';

import '../models/student.dart';

class StudentsList with ChangeNotifier {
  List<Student> LIST_STUDENTS = [
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
      gaveOffer: false,
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
      gaveOffer: false,
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
      gaveOffer: false,
      profileURL: 'assets/images/student_5.jpeg',
      resumeURL: 'assets/images/resume.jpg',
      personalStatement:
          'Now seven world think timed while her. Spoil large oh he rooms on since an. Am up unwilling eagerness perceived incommode. Are not windows set luckily musical hundred can. Collecting if sympathize middletons be of of reasonably. Horrible so kindness at thoughts exercise no weddings subjects. The mrs gay removed towards journey chapter females offered not. Led distrusts otherwise who may newspaper but. Last he dull am none he mile hold as. ',
    ),
  ];

  Student findById(String id) {
    return LIST_STUDENTS.firstWhere((student) => student.name == id);
  }

  List<Student> get offeredStudents {
    return LIST_STUDENTS.where((student) => student.gaveOffer).toList();
  }
}
