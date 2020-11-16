import 'package:flutter/material.dart';
import 'package:perfit_app/widgets/textfield_header.dart';

import '../../../../models/jobs_for_interns.dart';
import '../../../../widgets/dynamic_field.dart';
import '../../../../widgets/dropdownfield.dart';
import '../../../../widgets/textfield.dart';

class AddJobPage extends StatefulWidget {
  static const routeName = '/addJobPage';

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  String _jobTitle;
  String _jobDesciption;
  String _jobSpecialisationSelected;
  String _durationSelected;
  double _salary;
  String _end;
  String _start;
  bool _fullTime = false;
  bool _partTime = false;
  bool _dynamicFieldEmpty = false;
  List<Map<String, String>> _skillsets = [];
  final _formKey = GlobalKey<FormState>();

  List<String> _jobSpecialisations = [
    'Computer Science',
    'Information Systems',
    'Design',
    'Engineering',
    'Healthcare',
  ];

  List<String> _durations = [
    '3 months',
    '6 months',
    '9 months',
    '12 months',
  ];

  void _deleteField(List list, String id) {
    setState(() {
      list.removeWhere((item) => item['id'] == id);
      for (int i = 0; i < list.length; i++) {
        print(list[i]['id']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        title: Text(
          'PerFit',
          style: Theme.of(context).textTheme.headline1.copyWith(
                fontSize: 20,
                color: Theme.of(context).accentColor,
              ),
        ),
      ),
      body: Builder(
        builder: (ctx) => GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 25),
                  CustomTextField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    initValue: _jobTitle,
                    function: (val) {
                      _jobTitle = val;
                      print(_jobTitle);
                    },
                    labelText: 'Job title',
                    marginRight: 100.0,
                    obscure: false,
                    enableText: true,
                  ),
                  SizedBox(height: 25),
                  CustomDropdownField(
                    hintText: 'Job Specialisation',
                    items: _jobSpecialisations
                        .map(
                          (job) => DropdownMenuItem(
                            child: Text(job),
                            value: job,
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _jobSpecialisationSelected = val;
                          print(_jobSpecialisationSelected);
                        },
                      );
                    },
                    value: _jobSpecialisationSelected,
                  ),
                  SizedBox(height: 25),
                  CustomDropdownField(
                    hintText: 'Duration',
                    items: _durations
                        .map(
                          (duration) => DropdownMenuItem(
                            child: Text(duration),
                            value: duration,
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _durationSelected = val;
                          print(_durationSelected);
                        },
                      );
                    },
                    value: _durationSelected,
                  ),
                  SizedBox(height: 25),
                  TextFieldHeader(
                    context: context,
                    header: 'Job description',
                  ),
                  CustomTextField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    initValue: _jobDesciption,
                    function: (val) {
                      _jobDesciption = val;
                      print(_jobDesciption);
                    },
                    marginRight: 100.0,
                    obscure: false,
                    enableText: true,
                    maxLines: 3,
                  ),
                  SizedBox(height: 25),
                  TextFieldHeader(
                    context: context,
                    header: 'Job skillset requirements',
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 75.0 * _skillsets.length,
                    margin: EdgeInsets.only(left: 30, right: 50),
                    child: Column(
                      children: _skillsets
                          .map(
                            (skillset) => DynamicField(
                              function: (val) {
                                skillset['skillset'] = val;
                              },
                              item: skillset['skillset'],
                              key: ValueKey(skillset['id']),
                              deleteField: _deleteField,
                              labelText:
                                  'Skillset ${_skillsets.indexOf(skillset) + 1}',
                              list: _skillsets,
                              id: skillset['id'],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 30),
                    child: IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _skillsets.add({
                            'skillset': '',
                            'id': DateTime.now().toString()
                          });
                          print(DateTime.now().toString());
                          print(_skillsets.length);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 25),
                  TextFieldHeader(
                    context: context,
                    header: 'Working schedule',
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              activeColor: Theme.of(context).primaryColor,
                              value: _fullTime,
                              onChanged: (val) {
                                setState(() {
                                  _fullTime = !_fullTime;
                                  print(_fullTime);
                                });
                              },
                            ),
                            Text(
                              'Full time',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              activeColor: Theme.of(context).primaryColor,
                              value: _partTime,
                              onChanged: (val) {
                                setState(() {
                                  _partTime = !_partTime;
                                  print(_partTime);
                                });
                              },
                            ),
                            Text(
                              'Part time',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  CustomTextField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please enter a\nsalary';
                      }
                      return null;
                    },
                    initValue: _salary == null ? '' : '$_salary',
                    function: (val) {
                      _salary = double.parse(val);
                      _salary = num.parse(_salary.toStringAsFixed(2));
                      print(_salary);
                    },
                    labelText: 'Salary',
                    marginRight: 250.0,
                    obscure: false,
                    enableText: true,
                    textInputType: TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false,
                    ),
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: 100,
                    child: FlatButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          for (int i = 0; i < _skillsets.length; i++) {
                            if (_skillsets[i]['skillset'] == '') {
                              setState(
                                () {
                                  _dynamicFieldEmpty = true;
                                },
                              );
                              break;
                            }
                            _dynamicFieldEmpty = false;
                          }
                          if (_skillsets.length == 0) {
                            _dynamicFieldEmpty = false;
                          }
                          if (_dynamicFieldEmpty == false) {
                            if (_fullTime == false && _partTime == false) {
                              Scaffold.of(ctx).showSnackBar(SnackBar(
                                content: Text(
                                    'Please ensure at least one working schedule is selected'),
                                duration: Duration(seconds: 1),
                              ));
                            } else {
                              String id = DateTime.now().toString();
                              print(_salary);
                              print(id);
                              Navigator.pop(
                                context,
                                JobForInterns(
                                  jobRequirements: _skillsets,
                                  endMonth: _end,
                                  startMonth: _start,
                                  id: id,
                                  jobTitle: _jobTitle,
                                  duration: _durationSelected,
                                  jobSpecialisation: _jobSpecialisationSelected,
                                  jobDescription: _jobDesciption,
                                  fullTime: _fullTime,
                                  partTime: _partTime,
                                  salary: _salary,
                                ),
                              );
                            }
                          } else {
                            Scaffold.of(ctx).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Please ensure all skillset fields are filled.'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        } else {
                          Scaffold.of(ctx).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Adding job unsucessful. Please refer to above fields.'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 16, color: Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
