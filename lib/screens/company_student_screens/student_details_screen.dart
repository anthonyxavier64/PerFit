import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/loading.dart';
//import 'package:perfit_app/providers/students_list.dart';
//import 'package:perfit_app/dummy_data.dart';

class StudentDetailsScreen extends StatefulWidget {
  static const routeName = './student_details_screen';
  final DocumentSnapshot userData;
  final bool notSignedIn;
  final FirebaseUser currentUser;

  StudentDetailsScreen({this.userData, this.notSignedIn, this.currentUser});

  @override
  _StudentDetailsScreenState createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  bool _isLoading = false;
  bool _trueOffer = false;
  DocumentSnapshot currentUserData;
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    if (!widget.notSignedIn) {
      _alreadySentOffer();
    }
  }

  Future<void> _alreadySentOffer() async {
    setState(() {
      _isLoading = true;
    });
    currentUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot result = await Firestore.instance
        .collection('employers')
        .document(currentUser.uid)
        .collection('offers_sent')
        .document(widget.userData.documentID)
        .get();
    currentUserData = await Firestore.instance
        .collection('employers')
        .document(currentUser.uid)
        .get();
    if (!result.exists) {
      setState(() {
        _trueOffer = true;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  String _getSkillsets() {
    String skillsets = '';
    for (int i = 0; i < widget.userData['skillsets'].length - 1; i++) {
      skillsets +=
          '${(i + 1)}: ${widget.userData['skillsets'][i]['skillset']}\n';
    }
    skillsets +=
        '${widget.userData['skillsets'].length}: ${widget.userData['skillsets'][(widget.userData['skillsets'].length - 1)]['skillset']}';
    return skillsets;
  }

  String _getWokrExp() {
    String skillsets = '';
    for (int i = 0; i < widget.userData['work_experiences'].length - 1; i++) {
      skillsets +=
          '${(i + 1)}: ${widget.userData['work_experiences'][i]['workExp']}\n';
    }
    skillsets +=
        '${widget.userData['work_experiences'].length}: ${widget.userData['work_experiences'][(widget.userData['work_experiences'].length - 1)]['workExp']}';
    return skillsets;
  }

  String _getPastProjects() {
    String skillsets = '';
    for (int i = 0; i < widget.userData['past_projects'].length - 1; i++) {
      skillsets +=
          '${(i + 1)}: ${widget.userData['past_projects'][i]['pastProj']}\n';
    }
    skillsets +=
        '${widget.userData['past_projects'].length}: ${widget.userData['past_projects'][(widget.userData['past_projects'].length - 1)]['pastProj']}';
    return skillsets;
  }

  Future<void> _sendOffer(ctx) async {
    if (_trueOffer) {
      setState(() {
        _trueOffer = !_trueOffer;
      });
      print('sent');
      Scaffold.of(ctx).hideCurrentSnackBar();
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text('You gave an offer to ${widget.userData['name']}!'),
        duration: Duration(
          seconds: 2,
        ),
      ));
      await Firestore.instance
          .collection('students')
          .document(widget.userData.documentID)
          .collection('offers_received')
          .document(currentUser.uid)
          .setData({
        'company_name': currentUserData['company_name'],
        'company_address': currentUserData['company_address'],
        'industry': currentUserData['industry'],
        'logo': currentUserData['logo'],
        'about_company': currentUserData['about_company'],
        'benefits_for_interns': currentUserData['benefits_for_interns'],
        'company_registration_number':
            currentUserData['company_registration_number'],
        'employer_profile': currentUserData['employer_profile'],
        'jobs_for_interns': currentUserData['jobs_for_interns'],
        'name': currentUserData['name'],
        'office_number': currentUserData['office_number'],
        'past_projects': currentUserData['past_projects'],
        'personal_number': currentUserData['personal_number'],
        'showing_personal_number_on_profile':
            currentUserData['showing_personal_number_on_profile'],
      });
      await Firestore.instance
          .collection('employers')
          .document(currentUser.uid)
          .collection('offers_sent')
          .document(widget.userData.documentID)
          .setData(
        {
          'name': widget.userData['name'],
          'course': widget.userData['course'],
          'specialisation': widget.userData['specialisation'],
          'profile_image': widget.userData['profile_image'],
          'cv': widget.userData['cv'],
          'date_of_birth': widget.userData['date_of_birth'],
          'end_month': widget.userData['end_month'],
          'faculty': widget.userData['faculty'],
          'gender': widget.userData['gender'],
          'past_projects': widget.userData['past_projects'],
          'school': widget.userData['school'],
          'short_description': widget.userData['short_description'],
          'skillsets': widget.userData['skillsets'],
          'start_month': widget.userData['start_month'],
          'work_experiences': widget.userData['work_experiences'],
          'year_of_study': widget.userData['year_of_study'],
        },
      );
    } else {
      setState(() {
        _trueOffer = !_trueOffer;
      });
      print('removed');
      Scaffold.of(ctx).hideCurrentSnackBar();
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content:
              Text('You cancelled your offer to ${widget.userData['name']}!'),
          duration: Duration(
            seconds: 2,
          ),
        ),
      );
      await Firestore.instance
          .collection('students')
          .document(widget.userData.documentID)
          .collection('offers_received')
          .document(currentUser.uid)
          .delete();
      await Firestore.instance
          .collection('employers')
          .document(currentUser.uid)
          .collection('offers_sent')
          .document(widget.userData.documentID)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final studentName = ModalRoute.of(context).settings.arguments as String;
    // final selectedStudent =
    //     Provider.of<StudentsList>(context, listen: false).findById(studentName);
    // final offerList = Provider.of<Offers>(context);
    //final selectedStudent = DummyData.DUMMY_STUDENTS[1];
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Student Profile'),
        ),
        body: _isLoading
            ? Center(
                child: Loading(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 30,
                          ),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              widget.userData['profile_image'],
                              height: 120,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: mediaQueryData.size.width * 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 3, right: 10, left: 10),
                                child: Text(
                                  'Name: ${widget.userData['name']}',
                                  //'Name: djklajfdklfjlasdjfklasjf',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Course: ${widget.userData['course']}',
                                      //'Name: djklajfdklfjlasdjfklasjf',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                      //width: mediaQueryData.size.width * 0.4,
                                      child: Text(
                                        'School: ${widget.userData['school']}',
                                        //'Name: djklajfdklfjlasdjfklasjf',
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                    Text(
                                      'Date of birth: ${widget.userData['date_of_birth']}',
                                      //'Name: djklajfdklfjlasdjfklasjf',
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      'Year: ${widget.userData['year_of_study']}',
                                      //'Name: djklajfdklfjlasdjfklasjf',
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      width: mediaQueryData.size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Personal Statement',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Card(
                            elevation: 10,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              width: double.infinity,
                              child: Text(
                                '${widget.userData['short_description']}',
                                //'Name: djklajfdklfjlasdjfklasjf',
                                softWrap: true,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Skillsets',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (widget.userData['skillsets'].length > 0)
                            Card(
                              elevation: 10,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                width: double.infinity,
                                child: Text(
                                  _getSkillsets(),
                                  //'Name: djklajfdklfjlasdjfklasjf',
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Work Experiences',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (widget.userData['work_experiences'].length > 0)
                            Card(
                              elevation: 10,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                width: double.infinity,
                                child: Text(
                                  _getWokrExp(),
                                  //'Name: djklajfdklfjlasdjfklasjf',
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Past Projects',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (widget.userData['past_projects'].length > 0)
                            Card(
                              elevation: 10,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                width: double.infinity,
                                child: Text(
                                  _getPastProjects(),
                                  //'Name: djklajfdklfjlasdjfklasjf',
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Container(
                    //   padding: EdgeInsets.all(15),
                    //   width: mediaQueryData.size.width,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: <Widget>[
                    //       Padding(
                    //         padding: const EdgeInsets.all(10.0),
                    //         child: Text(
                    //           'CV',
                    //           style: TextStyle(
                    //             fontSize: 15,
                    //             fontFamily: 'Montserrat',
                    //             fontWeight: FontWeight.w700,
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: double.infinity,
                    //         padding: EdgeInsets.all(10),
                    //         child: Card(
                    //             elevation: 10,
                    //             child: Image.asset(selectedStudent.resumeURL)),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
        floatingActionButton: widget.notSignedIn
            ? null
            : Builder(
                builder: (ctx) {
                  return _isLoading
                      ? CircularProgressIndicator()
                      : FloatingActionButton(
                          onPressed: () => _sendOffer(ctx),
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(
                            _trueOffer ? Icons.accessibility_new : Icons.check,
                          ),
                        );
                },
              )
        // : Builder(
        //     builder: (BuildContext context) {
        //       return FloatingActionButton(
        //         backgroundColor: Theme.of(context).primaryColor,
        //         child: Icon(
        //             selectedStudent.gaveOffer
        //                 ? Icons.check
        //                 : Icons.accessibility_new,
        //             color: Theme.of(context).accentColor),
        //         onPressed: () {
        //           selectedStudent.toggleOffer();
        //           if (selectedStudent.gaveOffer) {
        //             offerList.addOfferStudent(
        //                 selectedStudent.name, selectedStudent.name);
        //             Scaffold.of(context).showSnackBar(
        //               SnackBar(
        //                 content: Text(
        //                     'You gave an offer to ${selectedStudent.name}!'),
        //                 duration: Duration(
        //                   seconds: 2,
        //                 ),
        //               ),
        //             );
        //           } else {
        //             offerList.cancelOfferStudent(selectedStudent.name);
        //             Scaffold.of(context).hideCurrentSnackBar();
        //             Scaffold.of(context).showSnackBar(
        //               SnackBar(
        //                 content: Text(
        //                     'You cancelled your offer to ${selectedStudent.name}!'),
        //                 duration: Duration(
        //                   seconds: 2,
        //                 ),
        //               ),
        //             );
        //           }
        //         },
        //       );
        //     },
        //   ),
        );
  }
}
