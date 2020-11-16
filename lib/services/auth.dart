import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:perfit_app/services/database.dart';

import '../models/user.dart';
import './database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword({
    String email,
    String password,
    bool employer,
    String name,
    String companyName,
    String companyAdd,
    String companyRegNo,
    String industry,
    int officeNum,
    int personalNum,
    bool personalNumOnProf,
    String aboutCompany,
    String internsGain,
    String dob,
    String gender,
    String start,
    String end,
    String school,
    String faculty,
    String course,
    String spec,
    int yearOfStudy,
    List skillsets,
    List pastProj,
    List workExp,
    List jobsForInterns,
    String shortDesc,
    File profileImage,
    File cvFile,
    File logo,
    File employerProfile,
  }) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      if (!employer) {
        await DatabaseService(uid: user.uid).updateStudentData(
          course: course,
          shortDesc: shortDesc,
          workExp: workExp,
          pastProj: pastProj,
          skillsets: skillsets,
          dateOfBirth: dob,
          end: end,
          start: start,
          faculty: faculty,
          gender: gender,
          name: name,
          school: school,
          specialisation: spec,
          yearOfStudy: yearOfStudy,
          image: profileImage,
          cv: cvFile,
        );
      } else {
        await DatabaseService(uid: user.uid).updateEmployerData(
          name: name,
          companyName: companyName,
          companyAdd: companyAdd,
          companyRegNum: companyRegNo,
          industry: industry,
          officeNum: officeNum,
          personalNum: personalNum,
          personalNumOnProf: personalNumOnProf,
          aboutCompany: aboutCompany,
          internsGain: internsGain,
          jobs: jobsForInterns,
          pastProj: pastProj,
          logo: logo,
          employerProfile: employerProfile,
        );
      }
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
