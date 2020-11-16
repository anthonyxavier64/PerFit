import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/loading.dart';
import '../../screens/home/chat_bar/chat_screen.dart';
import '../../models/chat.dart';
//import 'package:perfit_app/dummy_data.dart';

class CompanyDetailsScreen extends StatefulWidget {
  static const routeName = './company_details_screen';
  final DocumentSnapshot userData; // company
  final bool notSignedIn;
  final FirebaseUser currentUser; // student

  CompanyDetailsScreen({this.userData, this.notSignedIn, this.currentUser});

  @override
  _CompanyDetailsScreenState createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {
  bool _isLoading = false;
  bool _trueFavourite = false;
  FirebaseUser currentUser;
  DocumentSnapshot currentUserData;
  bool _sentOffer = false;

  @override
  void initState() {
    super.initState();
    _alreadyFavourited();
  }

  String _jobSkillsets(List skillsets) {
    String skills = 'Skillsets: ';
    if (skillsets.length == 1) {
      skills += '${skillsets[0]['skillset']}';
      return skills;
    }
    for (int i = 0; i < skillsets.length - 1; i++) {
      skills += '${skillsets[i]['skillset']}, ';
    }
    skills += '${skillsets[skillsets.length - 1]['skillset']}';
    return skills;
  }

  Future<void> _alreadyFavourited() async {
    setState(() {
      _isLoading = true;
    });
    currentUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot offered = await Firestore.instance
        .collection('students')
        .document(currentUser.uid)
        .collection('offers_received')
        .document(widget.userData.documentID)
        .get();
    if (offered.exists) {
      setState(() {
        _sentOffer = true;
      });
    }
    DocumentSnapshot result = await Firestore.instance
        .collection('students')
        .document(currentUser.uid)
        .collection('favourites_sent')
        .document(widget.userData.documentID)
        .get();
    currentUserData = await Firestore.instance
        .collection('students')
        .document(currentUser.uid)
        .get();
    if (!result.exists) {
      print('here');
      setState(() {
        _trueFavourite = true;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _sendFavourite(ctx) async {
    if (_trueFavourite) {
      setState(() {
        _trueFavourite = !_trueFavourite;
      });
      print('sent');
      Scaffold.of(ctx).hideCurrentSnackBar();
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text('You favourited ${widget.userData['name']}!'),
        duration: Duration(
          seconds: 2,
        ),
      ));
      await Firestore.instance
          .collection('employers')
          .document(widget.userData.documentID)
          .collection('favourites_received')
          .document(currentUser.uid)
          .setData({
        'name': currentUserData['name'],
        'course': currentUserData['course'],
        'specialisation': currentUserData['specialisation'],
        'profile_image': currentUserData['profile_image'],
        'cv': currentUserData['cv'],
        'date_of_birth': currentUserData['date_of_birth'],
        'end_month': currentUserData['end_month'],
        'faculty': currentUserData['faculty'],
        'gender': currentUserData['gender'],
        'past_projects': currentUserData['past_projects'],
        'school': currentUserData['school'],
        'short_description': currentUserData['short_description'],
        'skillsets': currentUserData['skillsets'],
        'start_month': currentUserData['start_month'],
        'work_experiences': currentUserData['work_experiences'],
        'year_of_study': currentUserData['year_of_study'],
      });
      await Firestore.instance
          .collection('students')
          .document(currentUser.uid)
          .collection('favourites_sent')
          .document(widget.userData.documentID)
          .setData(
        {
          'company_name': widget.userData['company_name'],
          'company_address': widget.userData['company_address'],
          'industry': widget.userData['industry'],
          'logo': widget.userData['logo'],
          'about_company': widget.userData['about_company'],
          'benefits_for_interns': widget.userData['benefits_for_interns'],
          'company_registration_number':
              widget.userData['company_registration_number'],
          'employer_profile': widget.userData['employer_profile'],
          'jobs_for_interns': widget.userData['jobs_for_interns'],
          'name': widget.userData['name'],
          'office_number': widget.userData['office_number'],
          'past_projects': widget.userData['past_projects'],
          'personal_number': widget.userData['personal_number'],
          'showing_personal_number_on_profile':
              widget.userData['showing_personal_number_on_profile'],
        },
      );
    } else {
      setState(() {
        _trueFavourite = !_trueFavourite;
      });
      print('removed');
      Scaffold.of(ctx).hideCurrentSnackBar();
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text('You unfavourited ${widget.userData['company_name']}!'),
          duration: Duration(
            seconds: 2,
          ),
        ),
      );
      await Firestore.instance
          .collection('employers')
          .document(widget.userData.documentID)
          .collection('favourites_received')
          .document(currentUser.uid)
          .delete();
      await Firestore.instance
          .collection('students')
          .document(currentUser.uid)
          .collection('favourites_sent')
          .document(widget.userData.documentID)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    //final selectedStudent = DummyData.DUMMY_STUDENTS[1];
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Company Profile'),
      ),
      body: _isLoading
          ? Center(child: Loading())
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
                            widget.userData['logo'],
                            height: 120,
                            width: 90,
                            fit: BoxFit.contain,
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
                                'Name: ${widget.userData['company_name']}',
                                //'Name: djklajfdklfjlasdjfklasjf',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Industry: ${widget.userData['industry']}',
                                    //'Name: djklajfdklfjlasdjfklasjf',
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  Container(
                                    //width: mediaQueryData.size.width * 0.4,
                                    child: Text(
                                      'Founder Name: ${widget.userData['name']}',
                                      //'Name: djklajfdklfjlasdjfklasjf',
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  Text(
                                    'Address: ${widget.userData['company_address']}',
                                    //'Name: djklajfdklfjlasdjfklasjf',
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  if (_sentOffer)
                                    RaisedButton(
                                      elevation: 10,
                                      color: Theme.of(context).primaryColor,
                                      child: Text(
                                        'Message',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                                      onPressed: () {
                                        String imageUrl =
                                            widget.userData['logo'];
                                        Navigator.of(context).pushNamed(
                                          ChatScreen.routeName,
                                          arguments: Chat(
                                              widget.userData.documentID,
                                              widget.userData['company_name'],
                                              false,
                                              imageUrl),
                                        );
                                      },
                                    )
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
                            'Jobs Available',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                            itemCount:
                                widget.userData['jobs_for_interns'].length,
                            itemBuilder: (ctx, index) => Card(
                              elevation: 10,
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Job Title:${widget.userData['jobs_for_interns'][index]['jobTitle']}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 8,
                                      width: 2,
                                    ),
                                    Text(
                                      'Duration: ${widget.userData['jobs_for_interns'][index]['duration']}',
                                    ),
                                    Text(
                                      _jobSkillsets(
                                          widget.userData['jobs_for_interns']
                                              [index]['skillsets']),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                        onPressed: () => _sendFavourite(ctx),
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          _trueFavourite
                              ? Icons.favorite_border
                              : Icons.favorite,
                          color: Color.fromRGBO(250, 20, 131, 1.0),
                        ),
                      );
              },
            ),
      // floatingActionButton: Builder(
      //   builder: (BuildContext context) {
      //     return FloatingActionButton(
      //       backgroundColor: Theme.of(context).primaryColor,
      //       child: Icon(
      //         selectedCompany.isFavourite
      //             ? Icons.favorite
      //             : Icons.favorite_border,
      //         color: Color.fromRGBO(250, 20, 131, 1.0),
      //       ),
      //       onPressed: () {
      //         selectedCompany.toggleFavourites();
      //         companies.updateList();
      //         if (selectedCompany.isFavourite) {
      //           Scaffold.of(context).hideCurrentSnackBar();
      //           Scaffold.of(context).showSnackBar(
      //             SnackBar(
      //               content: Text('You favourited ${selectedCompany.name}!'),
      //               duration: Duration(
      //                 seconds: 2,
      //               ),
      //             ),
      //           );
      //         } else {
      //           Scaffold.of(context).hideCurrentSnackBar();
      //           Scaffold.of(context).showSnackBar(
      //             SnackBar(
      //               content: Text('You unfavourited ${selectedCompany.name}!'),
      //               duration: Duration(
      //                 seconds: 2,
      //               ),
      //             ),
      //           );
      //         }
      //       },
      //     );
      //   },
      // ),
    );
  }
}
