import 'package:flutter/material.dart';

import '../../screens/home/home_bar/course_job_screen.dart';

class CourseWidget extends StatelessWidget {
  final String courseId;
  final bool isEmployer;
  final bool notSignedIn;

  CourseWidget(this.courseId, this.isEmployer, this.notSignedIn);

  final Map<String, Map<String, String>> map = {
    'COM': {
      'image': 'assets/images/computing.jpg',
      'name': 'COMPUTING',
      'description': 'IT, Games, AI, etc.'
    },
    'BIZ': {
      'image': 'assets/images/business.jpg',
      'name': 'BUSINESS',
      'description': 'Finance, Banking, etc.'
    },
    'ENG': {
      'image': 'assets/images/engin.jpg',
      'name': 'ENGINEERING',
      'description': 'Electricity, Biomedical, etc.'
    },
    'ARTS': {
      'image': 'assets/images/arts.jpg',
      'name': 'ARTS & SOCIAL SCIENCES',
      'description': 'Sociology, Literature, etc.'
    },
    'SCI': {
      'image': 'assets/images/science.jpg',
      'name': 'SCIENCE',
      'description': 'Chemistry, Biology, etc.'
    },
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(courseId);
        return Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CourseJobScreen(courseId, isEmployer, notSignedIn),
          ),
        );
      },
      child: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  child: Image.asset(map[courseId]['image'],
                      height: 100, width: 160, fit: BoxFit.cover),
                ),
                Container(
                  height: 100,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 150,
                  child: Text(
                    map[courseId]['name'],
                    style: TextStyle(
                        fontFamily: 'PatuaOne',
                        fontSize: 23,
                        color: Colors.white),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 10,
            ),
            child: SizedBox(
              height: 20,
              width: 150,
              child: Text(
                map[courseId]['description'],
                style: Theme.of(context).textTheme.headline2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
