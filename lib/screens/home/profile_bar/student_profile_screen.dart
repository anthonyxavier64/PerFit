import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../authenticate/registration/student_registration/student_registration_screen.dart';

class StudentProfileScreen extends StatefulWidget {
  static const routeName = './studentProfileScreen';
  final DocumentSnapshot currentUser;
  final bool notSignedIn;

  StudentProfileScreen(this.currentUser, {this.notSignedIn = false});

  @override
  _StudentProfileScreenState createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  List<String> _pastProjects = [];
  List<String> _skillsets = [];
  List<String> _workExperiences = [];

  @override
  void initState() {
    super.initState();
    if (!widget.notSignedIn) {
      for (int i = 0; i < widget.currentUser['past_projects'].length; i++) {
        _pastProjects.add(widget.currentUser['past_projects'][i]['pastProj']);
      }
      for (int i = 0; i < widget.currentUser['skillsets'].length; i++) {
        _skillsets.add(widget.currentUser['skillsets'][i]['skillset']);
      }
      for (int i = 0; i < widget.currentUser['work_experiences'].length; i++) {
        _workExperiences
            .add(widget.currentUser['work_experiences'][i]['workExp']);
      }
    }
  }

  Widget _buildListDetails(String title, List list) {
    String string = '';
    if (list.length == 1) {
      string += '${list[0]}';
    } else {
      for (int i = 0; i < list.length - 1; i++) {
        print('here');
        string += '${list[i]}, ';
      }
      string += '${list[(list.length - 1)]}';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Divider(
          color: Theme.of(context).primaryColor,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 25),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 20,
              ),
              children: [
                TextSpan(
                  text: title,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: string,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetails(String title, String data, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Divider(
          color: Theme.of(context).primaryColor,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 25),
          child: RichText(
            text: TextSpan(
                style: TextStyle(
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: title,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: data,
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ]),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.notSignedIn
        ? Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                Text(
                  'Not a user yet? Sign up here!',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                RaisedButton(
                  child: Text('Sign up'),
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(StudentRegistrationPage.routeName),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 52,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: CircleAvatar(
                        backgroundImage:
                            widget.currentUser['profile_image'] != null
                                ? NetworkImage(
                                    widget.currentUser['profile_image'],
                                  )
                                : null,
                        radius: 50,
                        backgroundColor: Theme.of(context).accentColor,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.currentUser['name'],
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            widget.currentUser['date_of_birth'] != null
                                ? 'Date of birth: ${widget.currentUser['date_of_birth']}'
                                : 'Date of birth: unknown',
                            style: TextStyle(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                _buildDetails('About: ',
                    '${widget.currentUser['short_description']}', context),
                _buildDetails(
                    'Gender: ', '${widget.currentUser['gender']}', context),
                _buildDetails(
                    'School: ', '${widget.currentUser['school']}', context),
                _buildDetails('Year of study: ',
                    '${widget.currentUser['year_of_study']}', context),
                _buildDetails(
                    'Faculty: ', '${widget.currentUser['faculty']}', context),
                _buildDetails(
                    'Course: ', '${widget.currentUser['course']}', context),
                _buildDetails('Specialisation: ',
                    '${widget.currentUser['specialisation']}', context),
                _buildDetails(
                    'Availability: ',
                    widget.currentUser['start_month'] == null &&
                            widget.currentUser['end_month'] == null
                        ? 'NIL'
                        : widget.currentUser['start_month'] != null &&
                                widget.currentUser['end_month'] != null
                            ? '${widget.currentUser['start_month']} to ${widget.currentUser['end_month']}'
                            : widget.currentUser['start_month'] != null
                                ? 'Start on ${widget.currentUser['start_month']}'
                                : 'End on ${widget.currentUser['end_month']}',
                    context),
                if (_skillsets.length > 0)
                  _buildListDetails('Skillsets: ', _skillsets),
                if (_pastProjects.length > 0)
                  _buildListDetails('Past projects: ', _pastProjects),
                if (_workExperiences.length > 0)
                  _buildListDetails('Work experiences: ', _workExperiences),
              ],
            ),
          );
  }
}
