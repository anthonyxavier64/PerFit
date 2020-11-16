import 'package:flutter/material.dart';
import 'package:perfit_app/screens/company_student_screens/company_details_screen.dart';
import 'package:perfit_app/screens/company_student_screens/student_details_screen.dart';
import 'package:provider/provider.dart';

import '../../models/student.dart';
import '../../models/company.dart';

class OfferWidget extends StatelessWidget {
  final bool isStudent;

  OfferWidget(this.isStudent);

  @override
  Widget build(BuildContext context) {
    final company = isStudent ? Provider.of<Company>(context) : null;
    final student = isStudent ? null : Provider.of<Student>(context);

    return GestureDetector(
      onTap: () => isStudent
          ? Navigator.of(context)
              .pushNamed(CompanyDetailsScreen.routeName, arguments: company.id)
          : Navigator.of(context).pushNamed(
              StudentDetailsScreen.routeName,
              arguments: student.name,
            ),
      child: Container(
        //height: 150,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              isStudent
                  ? Container(
                      margin: EdgeInsets.all(10),
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
                        child: Image.asset(
                          company.logoURL,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(3),
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //color: Theme.of(context).primaryColorDark,
                        color: Colors.black54,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          student.profileURL,
                          height: 75,
                          width: 75,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              Container(
                  height: 140,
                  width: 200,
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        height: 20,
                        width: 140,
                        child: Text(
                          isStudent ? company.name : student.name,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 140,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                isStudent
                                    ? 'Industry: ${company.industry}'
                                    : 'Course: ${student.course}',
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            Container(
                              child: Text(
                                isStudent
                                    ? 'Founder Name: ${company.founderName}'
                                    : 'School: ${student.school}',
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            Text(
                              'Job Offered: Software Engineer Intern}',
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Text(
                              'Date Offered: 23/04/2020',
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline5,
                            )
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
