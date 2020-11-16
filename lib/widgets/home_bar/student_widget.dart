import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:perfit_app/dummy_data.dart';

import '../../screens/company_student_screens/student_details_screen.dart';
import '../../models/student.dart';

class StudentWidget extends StatelessWidget {
  /*final Student student;

  StudentWidget(this.student);
  */

  @override
  Widget build(BuildContext context) {
    //Widget _buildText(String)

    final student = Provider.of<Student>(context, listen: false);

    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        StudentDetailsScreen.routeName,
        arguments: student.name,
        //arguments: companyId,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(3),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              //color: Theme.of(context).primaryColorDark,
              color: Colors.black54,
            ),
            child: ClipOval(
              child: Image.asset(
                student.profileURL,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 50,
            width: 130,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  '${student.name}',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  'Course: ${student.course}',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  'School: ${student.school}',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
              //Text('Course: ${student.course}')
            ),
          ),
        ],
      ),
    );
  }
}
