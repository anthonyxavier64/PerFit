import 'package:flutter/material.dart';

class JobForInterns {
  final String jobTitle;
  final String jobSpecialisation;
  final String duration;
  final String startMonth;
  final String endMonth;
  final String jobDescription;
  final List jobRequirements;
  final bool fullTime;
  final bool partTime;
  final double salary;
  final String id;

  JobForInterns({
    @required this.jobTitle,
    @required this.jobSpecialisation,
    @required this.jobDescription,
    @required this.duration,
    @required this.fullTime,
    @required this.partTime,
    @required this.salary,
    @required this.id,
    @required this.startMonth,
    @required this.endMonth,
    @required this.jobRequirements,
  });
}
