import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference studentDataCollection =
      Firestore.instance.collection('students');

  final CollectionReference employerDataCollection =
      Firestore.instance.collection('employers');

  Future updateStudentData({
    String name,
    String dateOfBirth,
    String gender,
    String start,
    String end,
    String school,
    String faculty,
    String course,
    String specialisation,
    int yearOfStudy,
    List skillsets,
    List pastProj,
    List workExp,
    String shortDesc,
    File image,
    File cv,
  }) async {
    var imageUrl = '';
    var cvUrl = '';
    if (image != null) {
      var ref = FirebaseStorage.instance
          .ref()
          .child('student_images')
          .child(uid + '.jpg');
      await ref.putFile(image).onComplete;
      imageUrl = await ref.getDownloadURL();
    }
    if (cv != null) {
      var ref = FirebaseStorage.instance
          .ref()
          .child('student_cv')
          .child(uid + '.docx');
      await ref.putFile(cv).onComplete;
      cvUrl = await ref.getDownloadURL();
    }
    return await studentDataCollection.document(uid).setData({
      'name': name,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'start_month': start,
      'end_month': end,
      'school': school,
      'faculty': faculty,
      'course': course,
      'specialisation': specialisation,
      'year_of_study': yearOfStudy,
      'skillsets': skillsets,
      'past_projects': pastProj,
      'work_experiences': workExp,
      'short_description': shortDesc,
      'profile_image': imageUrl,
      'cv': cvUrl,
    });
  }

  Future updateEmployerData({
    String name,
    String companyName,
    String companyAdd,
    String companyRegNum,
    String industry,
    int officeNum,
    int personalNum,
    bool personalNumOnProf,
    String aboutCompany,
    String internsGain,
    List jobs,
    List pastProj,
    File logo,
    File employerProfile,
  }) async {
    var imageUrl = '';
    var profileUrl = '';
    if (logo != null) {
      var ref = FirebaseStorage.instance
          .ref()
          .child('company_logos')
          .child(uid + '.jpg');
      await ref.putFile(logo).onComplete;
      imageUrl = await ref.getDownloadURL();
    }
    if (employerProfile != null) {
      var ref = FirebaseStorage.instance
          .ref()
          .child('employer_profile')
          .child(uid + '.docx');
      await ref.putFile(employerProfile).onComplete;
      profileUrl = await ref.getDownloadURL();
    }
    return await employerDataCollection.document(uid).setData(
      {
        'name': name,
        'company_name': companyName,
        'company_address': companyAdd,
        'company_registration_number': companyRegNum,
        'office_number': officeNum,
        'personal_number': personalNum,
        'showing_personal_number_on_profile': personalNumOnProf,
        'about_company': aboutCompany,
        'benefits_for_interns': internsGain,
        'jobs_for_interns': jobs,
        'past_projects': pastProj,
        'logo': imageUrl,
        'employer_profile': profileUrl,
        'industry': industry,
      },
    );
  }
}
