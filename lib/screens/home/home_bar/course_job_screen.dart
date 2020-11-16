import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:perfit_app/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../company_student_screens/student_details_screen.dart';
import '../../company_student_screens/company_details_screen.dart';
//import '../widgets/job_widget.dart';

class CourseJobScreen extends StatefulWidget {
  static const routeName = '/course_job_screen';
  final String courseId;
  final bool isEmployer;
  final bool notSignedIn;

  CourseJobScreen(this.courseId, this.isEmployer, this.notSignedIn);

  @override
  _CourseJobScreenState createState() => _CourseJobScreenState();
}

class _CourseJobScreenState extends State<CourseJobScreen> {
  String imageUrl = '';
  String appBarTitle = '';
  String studentSearchKey = '';
  String employerSearchKey = '';
  List<DocumentSnapshot> displayUsers = [];
  bool _isLoading = false;
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    switch (widget.courseId) {
      case 'COM':
        appBarTitle = 'Computing';
        imageUrl = 'assets/images/computing.jpg';
        studentSearchKey = 'Computing';
        employerSearchKey = 'Technology';
        break;
      case 'BIZ':
        appBarTitle = 'Business';
        imageUrl = 'assets/images/business.jpg';
        studentSearchKey = 'Business';
        employerSearchKey = 'Finance';
        break;
      case 'ENG':
        appBarTitle = 'Engineering';
        imageUrl = 'assets/images/engin.jpg';
        studentSearchKey = 'Engineering';
        employerSearchKey = 'Manufacturing';
        break;
      case 'ARTS':
        appBarTitle = 'Arts';
        imageUrl = 'assets/images/arts.jpg';
        studentSearchKey = 'FASS';
        employerSearchKey = 'Communications';
        break;
      case 'SCI':
        appBarTitle = 'Science';
        imageUrl = 'assets/images/science.jpg';
        studentSearchKey = 'Science';
        employerSearchKey = 'Research';
        break;
      default:
        appBarTitle = 'PerFit!';
    }
    _getUsers();
  }

  Future<void> _getUsers() async {
    setState(() {
      _isLoading = true;
    });
    QuerySnapshot result;
    !widget.isEmployer
        ? result = await Firestore.instance
            .collection('employers')
            .where('industry', isEqualTo: employerSearchKey)
            .getDocuments()
        : result = await Firestore.instance
            .collection('students')
            .where('faculty', isEqualTo: studentSearchKey)
            .getDocuments();
    for (int i = 0; i < result.documents.length; i++) {
      displayUsers.add(result.documents[i]);
    }
    currentUser = await FirebaseAuth.instance.currentUser();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.black),
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: imageUrl != ''
                  ? Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                    )
                  : null,
              titlePadding: EdgeInsets.only(
                left: 20,
                bottom: 5,
              ),
              title: Text(
                appBarTitle,
                style: TextStyle(
                  backgroundColor: Colors.black38,
                ),
              ),
            ),
          ),
          _isLoading
              ? SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      SizedBox(
                        height: 50,
                      ),
                      Loading(),
                    ],
                  ),
                )
              : displayUsers.length <= 0
                  ? SliverList(
                      delegate: SliverChildListDelegate.fixed(
                        [
                          SizedBox(height: 100),
                          Center(
                            child: Text(
                              widget.isEmployer
                                  ? 'No students found.'
                                  : 'No companies found.',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildListDelegate(
                        List.generate(
                          displayUsers.length,
                          (index) {
                            return GestureDetector(
                              onTap: () {
                                widget.isEmployer
                                    ? Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              StudentDetailsScreen(
                                                  userData: displayUsers[index],
                                                  notSignedIn:
                                                      widget.notSignedIn,
                                                  currentUser: currentUser),
                                        ),
                                      )
                                    : Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CompanyDetailsScreen(
                                                    userData:
                                                        displayUsers[index],
                                                    notSignedIn:
                                                        widget.notSignedIn,
                                                    currentUser: currentUser)));
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 52,
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: !widget.isEmployer
                                              ? displayUsers[index]['logo'] !=
                                                      null
                                                  ? NetworkImage(
                                                      displayUsers[index]
                                                          ['logo'])
                                                  : null
                                              : displayUsers[index]
                                                          ['profile_image'] !=
                                                      null
                                                  ? NetworkImage(
                                                      displayUsers[index]
                                                          ['profile_image'])
                                                  : null,
                                          backgroundColor:
                                              Theme.of(context).accentColor,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: !widget.isEmployer
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Company name: ${displayUsers[index]['company_name']}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Divider(),
                                                  Text(
                                                    'Address: ${displayUsers[index]['company_address']}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Divider(),
                                                  Text(
                                                    'Office no: ${displayUsers[index]['office_number']}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Name: ${displayUsers[index]['name']}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Divider(),
                                                  Text(
                                                    'Course: ${displayUsers[index]['course']}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Divider(),
                                                  Text(
                                                    'Specialisation: ${displayUsers[index]['specialisation']}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
