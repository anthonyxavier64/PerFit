import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:perfit_app/models/company.dart';
import 'package:perfit_app/screens/company_student_screens/company_details_screen.dart';
import 'package:perfit_app/screens/company_student_screens/student_details_screen.dart';
import 'package:perfit_app/widgets/home_bar/new_students_joined_widget.dart';
import 'package:provider/provider.dart';

import '../../../widgets/home_bar/headings_widget.dart';
import '../../../widgets/home_bar/student_widget.dart';
import '../../../widgets/home_bar/companies_widget.dart';
import '../../../widgets/home_bar/course_widget.dart';
import '../../../widgets/home_bar/offer_widget.dart';
import '../../../providers/offers.dart';
import '../../../providers/companies_list.dart';
import '../../../providers/students_list.dart';
import '../../../models/student.dart';
//import '../../../models/';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';
  final bool isEmployer;
  final DocumentSnapshot currentUser;
  final bool notSignedIn;

  HomeScreen(this.isEmployer, this.currentUser, this.notSignedIn);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //List<Map<String, String>> _courseName = [];

  bool isStudent;

  @override
  void initState() {
    super.initState();
    isStudent = !widget.isEmployer;
  }

  Widget _buildFavouriteCard(DocumentSnapshot snapshot, context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return !widget.isEmployer
                ? CompanyDetailsScreen(
                    userData: snapshot,
                    notSignedIn: widget.notSignedIn,
                  )
                : StudentDetailsScreen(
                    userData: snapshot,
                    notSignedIn: widget.notSignedIn,
                  );
          },
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 17,
            ),
            padding: EdgeInsets.all(3),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              //color: Theme.of(context).primaryColorDark,
              color: Colors.black54,
            ),
            child: Container(
              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: widget.isEmployer
                  ? Image.network(
                      snapshot['profile_image'],
                      fit: BoxFit.cover,
                    )
                  : Image.network(snapshot['logo'], fit: BoxFit.cover),
            ),
          ),
          Container(
            height: 30,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Text(
              widget.isEmployer ? snapshot['name'] : snapshot['company_name'],
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard(DocumentSnapshot snapshot, context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return !widget.isEmployer
                ? CompanyDetailsScreen(
                    userData: snapshot,
                    notSignedIn: widget.notSignedIn,
                  )
                : StudentDetailsScreen(
                    userData: snapshot,
                    notSignedIn: widget.notSignedIn,
                  );
          },
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 52,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: widget.isEmployer
                        ? snapshot['profile_image'] != null
                            ? NetworkImage(snapshot['profile_image'])
                            : null
                        : snapshot['logo'] != null
                            ? NetworkImage(snapshot['logo'])
                            : null,
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: !widget.isEmployer
                      ? Container(
                          margin: EdgeInsets.symmetric(vertical: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Company name: ${snapshot['company_name']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Divider(),
                              Text(
                                'Address: ${snapshot['company_address']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Divider(),
                              Text(
                                'Industry: ${snapshot['industry']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(vertical: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Name: ${snapshot['name']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Divider(),
                              Text(
                                'Course: ${snapshot['course']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Divider(),
                              Text(
                                'Specialisation: ${snapshot['specialisation']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHoriScroll(List<Widget> widgetList) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: widgetList,
      ),
    );
  }

  Widget _companyListBuilder(List<Company> widgetList) {
    return widgetList.length == 0
        ? Container(
            height: 200,
            width: double.infinity,
            child: Container(
              child: Image.asset(
                'assets/images/no_favourites.png',
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container(
            height: 200,
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widgetList.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: widgetList[i],
                child: CompanyWidget(),
              ),

              //itemBuilder: (ctx, i) => ,
            ),
          );
  }

  Widget _studentListBuilder(List<Student> widgetList) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widgetList.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: widgetList[i],
          child: StudentWidget(),
        ),
      ),
    );
  }

  Widget _offerListBuilderCompanies(
      Map<String, OfferItem> widgetList, context) {
    return widgetList.length == 0
        ? Container(
            height: 200,
            width: double.infinity,
            child: Container(
              child: Image.asset(
                'assets/images/no_offers.png',
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container(
            height: 200,
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widgetList.length,
              itemBuilder: (ctx, i) {
                return ChangeNotifierProvider.value(
                  value: Provider.of<CompaniesList>(context)
                      .LIST_COMPANIES
                      .firstWhere((company) =>
                          company.id ==
                          widgetList.values.toList()[i].companyId),
                  child: OfferWidget(true),
                );
              },
            ),
          );
  }

  Widget _offerListBuilderStudents(
      Map<String, OfferItem> offeredStudents, context) {
    return offeredStudents.length == 0
        ? Container(
            height: 200,
            width: double.infinity,
            child: Container(
              child: Image.asset(
                'assets/images/offers.png',
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container(
            height: 200,
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: offeredStudents.length,
              itemBuilder: (ctx, i) {
                return ChangeNotifierProvider.value(
                  value: Provider.of<StudentsList>(context)
                      .LIST_STUDENTS
                      .firstWhere((student) =>
                          student.name ==
                          offeredStudents.values.toList()[i].studentId),
                  child: OfferWidget(false),
                );
              },
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    //MediaQueryData mediaQuery = MediaQuery.of(context);

    final companiesList = Provider.of<CompaniesList>(context);
    final offers = Provider.of<Offers>(context);
    return //LayoutBuilder(builder: (ctx, constraints) {
        ListView(
      //padding: const EdgeInsets.all(15),
      children: <Widget>[
        Heading('COURSES', isStudent),
        _buildHoriScroll(
          [
            CourseWidget('COM', widget.isEmployer, widget.notSignedIn),
            CourseWidget('BIZ', widget.isEmployer, widget.notSignedIn),
            CourseWidget('ARTS', widget.isEmployer, widget.notSignedIn),
            CourseWidget('SCI', widget.isEmployer, widget.notSignedIn),
            CourseWidget('ENG', widget.isEmployer, widget.notSignedIn),
          ],
        ),
        Heading('NEW', isStudent),
        isStudent
            ? _companyListBuilder(companiesList.LIST_COMPANIES)
            : NewStudentsJoined(),
        Heading('OFFER', isStudent),
        !widget.notSignedIn
            ? StreamBuilder(
                stream: isStudent
                    ? Firestore.instance
                        .collection('students')
                        .document(widget.currentUser.documentID)
                        .collection('offers_received')
                        .snapshots()
                    : Firestore.instance
                        .collection('employers')
                        .document(widget.currentUser.documentID)
                        .collection('offers_sent')
                        .snapshots(),
                builder: (ctx, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                      ),
                    );
                  }
                  if (snapshots.data.documents.length > 0) {
                    return Container(
                      width: 200,
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshots.data.documents.length,
                        itemBuilder: (ctx, index) {
                          return _buildOfferCard(
                              snapshots.data.documents[index], context);
                        },
                      ),
                    );
                  } else {
                    return isStudent
                        ? _offerListBuilderCompanies(
                            offers.offerListCompanies, context)
                        : _offerListBuilderStudents(
                            offers.offerListStudents, context);
                  }
                },
              )
            : isStudent
                ? _offerListBuilderCompanies(offers.offerListCompanies, context)
                : _offerListBuilderStudents(offers.offerListStudents, context),
        SizedBox(height: 50, width: 50),
        Heading('FAVOURITES', isStudent),
        !widget.notSignedIn
            ? StreamBuilder(
                stream: isStudent
                    ? Firestore.instance
                        .collection('students')
                        .document(widget.currentUser.documentID)
                        .collection('favourites_sent')
                        .snapshots()
                    : Firestore.instance
                        .collection('employers')
                        .document(widget.currentUser.documentID)
                        .collection('favourites_received')
                        .snapshots(),
                builder: (ctx, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                      ),
                    );
                  }
                  if (snapshots.data.documents.length > 0) {
                    return Container(
                      width: 200,
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshots.data.documents.length,
                        itemBuilder: (ctx, index) {
                          return _buildFavouriteCard(
                              snapshots.data.documents[index], context);
                        },
                      ),
                    );
                  } else {
                    return _companyListBuilder(
                        companiesList.favouriteCompanies);
                  }
                },
              )
            : _companyListBuilder(companiesList.favouriteCompanies),
      ],
    );
  }
}
