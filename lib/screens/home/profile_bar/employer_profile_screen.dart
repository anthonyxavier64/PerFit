import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:perfit_app/models/jobs_for_interns.dart';

import '../../authenticate/registration/employer_registration/employer_registration_screen.dart';

class EmployerProfileScreen extends StatefulWidget {
  static const routeName = './employerProfileScreen';
  final DocumentSnapshot currentUser;
  final bool notSignedIn;

  EmployerProfileScreen(this.currentUser, {this.notSignedIn = false});

  @override
  _EmployerProfileScreenState createState() => _EmployerProfileScreenState();
}

class _EmployerProfileScreenState extends State<EmployerProfileScreen> {
  List<JobForInterns> _jobs = [];
  List<String> _pastProjects = [];
  List<List> _specificJobSkills = [];

  @override
  void initState() {
    super.initState();
    if (!widget.notSignedIn) {
      for (int i = 0; i < widget.currentUser['jobs_for_interns'].length; i++) {
        List<String> _jobSkills = [];
        var currentJob = widget.currentUser['jobs_for_interns'][i];
        _jobs.add(
          JobForInterns(
            jobTitle: currentJob['jobTitle'],
            jobSpecialisation: currentJob['jobSpec'],
            jobDescription: currentJob['jobDesc'],
            duration: currentJob['duration'],
            fullTime: currentJob['fullTime'],
            partTime: currentJob['partTime'],
            salary: currentJob['salary'],
            id: currentJob['id'],
            startMonth: currentJob['startMonth'],
            endMonth: currentJob['endMonth'],
            jobRequirements: currentJob['skillsets'],
          ),
        );
        for (int i = 0; i < currentJob['skillsets'].length; i++) {
          _jobSkills.add(currentJob['skillsets'][i]['skillset']);
        }
        _specificJobSkills.add(_jobSkills);
      }
      for (int i = 0; i < widget.currentUser['past_projects'].length; i++) {
        _pastProjects.add(widget.currentUser['past_projects'][i]['pastProj']);
      }
    }
  }

  List<Widget> _buildJobs(BuildContext context) {
    List<Widget> listOfJobs = [];
    for (int i = 0; i < _jobs.length; i++) {
      listOfJobs.add(
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildDetailsForJobs(
                      'Job title: ', _jobs[i].jobTitle, context),
                  _buildDetailsForJobs('Job specialisation: ',
                      _jobs[i].jobSpecialisation, context),
                  _buildDetailsForJobs(
                      'Job description: ', _jobs[i].jobDescription, context),
                  _buildDetailsForJobs(
                      'Job duration: ', _jobs[i].duration, context),
                  if (_jobs[i].startMonth != null)
                    _buildDetailsForJobs(
                        'Job starting month: ', _jobs[i].startMonth, context),
                  if (_jobs[i].endMonth != null)
                    _buildDetailsForJobs(
                        'Job ending month: ', _jobs[i].endMonth, context),
                  _jobs[i].fullTime == true && _jobs[i].partTime == true
                      ? _buildDetailsForJobs(
                          'Work schedule: ', 'full-time/part-time', context)
                      : _jobs[i].fullTime == true
                          ? _buildDetailsForJobs(
                              'Work schedule: ', 'full-time', context)
                          : _buildDetailsForJobs(
                              'Work schedule: ', 'part-time', context),
                  _buildDetailsForJobs(
                      'Salary: ', '\$${_jobs[i].salary.toString()}', context),
                  if (_specificJobSkills.length > 0)
                    _buildListDetails(
                        'Job requirements: ', _specificJobSkills[i]),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    }
    return listOfJobs;
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
                ]),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsForJobs(String title, String data, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
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
                      .pushReplacementNamed(EmployerRegistrationPage.routeName),
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
                        backgroundImage: widget.currentUser['logo'] != null
                            ? NetworkImage(
                                widget.currentUser['logo'],
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
                            widget.currentUser['company_name'],
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
                            widget.currentUser['company_registration_number'] !=
                                    null
                                ? 'Reg no: ${widget.currentUser['company_registration_number']}'
                                : 'Reg no: unknown',
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
                _buildDetails(
                    'Industry: ', '${widget.currentUser['industry']}', context),
                _buildDetails('About: ',
                    '${widget.currentUser['about_company']}', context),
                _buildDetails('Address : ',
                    '${widget.currentUser['company_address']}', context),
                _buildDetails('Founder\'s name: ',
                    '${widget.currentUser['name']}', context),
                _buildDetails('Office number: ',
                    '${widget.currentUser['office_number']}', context),
                if (widget.currentUser['showing_personal_number_on_profile'])
                  _buildDetails('Personal number: ',
                      '${widget.currentUser['personal_number']}', context),
                _buildDetails('Benefits for interns: ',
                    '${widget.currentUser['benefits_for_interns']}', context),
                if (_pastProjects.length > 0)
                  _buildListDetails('Past projects: ', _pastProjects),
                Divider(
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 20),
                if (_jobs.length > 0)
                  Text(
                    'Jobs posted',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                SizedBox(height: 10),
                if (_jobs.length > 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildJobs(context),
                  ),
              ],
            ),
          );
  }
}
