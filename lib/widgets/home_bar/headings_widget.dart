import 'package:flutter/material.dart';

import '../../screens/home/favourites_bar/favourited_students_screen.dart';
import '../../screens/home/favourites_bar/favourites_companies_screen.dart';
import '../../screens/home/home_bar/new_companies_screen.dart';
import '../../screens/home/home_bar/offer_status_employer_screen.dart';
import '../../screens/home/home_bar/offer_status_student_screen.dart';

class Heading extends StatelessWidget {
  final bool isStudent;
  final String headingName;

  Heading(this.headingName, this.isStudent);

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, Object>> mapStudent = {
      'COURSES': {
        'description': 'View jobs relevant to your courses!',
        'icon': Icon(
          Icons.book,
          color: Color.fromRGBO(150, 209, 0, 1.0),
          //color: Color.fromRGBO(250, 20, 131, 1.0),
        ),
      },
      'FAVOURITES': {
        'route': FavouritesCompaniesScreen.routeName,
        'description': 'View your favourited companies!',
        'icon': Icon(
          Icons.favorite,
          color: Color.fromRGBO(250, 20, 131, 1.0),
        ),
      },
      'NEW': {
        'route': NewCompaniesScreen.routeName,
        'description': 'New companies that have joined PerFit!',
        'icon': Icon(
          Icons.new_releases,
          color: Color.fromRGBO(153, 69, 237, 1.0),
          //color: Color.fromRGBO(250, 20, 131, 1.0),
        ),
      },
      'OFFER': {
        'route': OfferStatusStudentScreen.routeName,
        'description': 'View your offer status!',
        'icon': Icon(
          Icons.accessibility_new,
          color: Color.fromRGBO(255, 179, 0, 1.0),
        ),
      }
    };

    Map<String, Map<String, Object>> mapEmployer = {
      'COURSES': {
        'description': 'View students from your choice of courses!',
        'icon': Icon(
          Icons.book,
          color: Color.fromRGBO(111, 201, 0, 1.0),
          //color: Color.fromRGBO(250, 20, 131, 1.0),
        ),
      },
      'FAVOURITES': {
        'route': FavouritedStudentsScreen.routeName,
        'description':
            'View students who have indicated their interest in your company!',
        'icon': Icon(
          Icons.favorite,
          color: Color.fromRGBO(250, 20, 131, 1.0),
        ),
      },
      'NEW': {
        'description':
            'This is the number of students who have joined PerFit in the last week!',
        'icon': Icon(
          Icons.new_releases,
          color: Color.fromRGBO(153, 69, 237, 1.0),
          //color: Color.fromRGBO(250, 20, 131, 1.0),
        ),

        /*'icon': SizedBox(
          height: 0,
          width: 0,
        )*/
      },
      'OFFER': {
        'description': 'View your offer status!',
        'route': OfferStatusEmployerScreen.routeName,
        'icon': Icon(
          Icons.accessibility_new,
          color: Color.fromRGBO(255, 179, 0, 1.0),
        ),
      }
    };

    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20, top: 30, bottom: 15),
      child: headingName == 'COURSES' || (!isStudent && headingName == 'NEW')
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      isStudent || headingName == 'COURSES' ? 'COURSES' : 'NEW',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      width: 8,
                      height: 8,
                    ),
                    isStudent || headingName == 'COURSES'
                        ? mapStudent['COURSES']['icon']
                        : mapEmployer['NEW']['icon'],
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(right: 5),
                  child: Text(
                    isStudent
                        ? mapStudent['COURSES']['description']
                        : headingName == 'COURSES'
                            ? mapEmployer['COURSES']['description']
                            : mapEmployer['NEW']['description'],
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ],
            )
          : GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(isStudent
                  ? mapStudent[headingName]['route']
                  : mapEmployer[headingName]['route']),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        headingName,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(
                        width: 8,
                        height: 8,
                      ),
                      mapStudent[headingName]['icon'],
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 6),
                    child: Text(
                      isStudent
                          ? mapStudent[headingName]['description']
                          : mapEmployer[headingName]['description'],
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
