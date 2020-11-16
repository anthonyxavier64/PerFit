import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/company.dart';
import '../../../models/student.dart';

class SearchListIconCompany extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final company = Provider.of<Company>(context);

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 10,
      ),
      padding: EdgeInsets.all(3),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        //color: Theme.of(context).primaryColorDark,
        color: Colors.black54,
      ),
      child: Container(
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Image.asset(
          company.logoURL,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class SearchListIconStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final student = Provider.of<Student>(context);
    return Container(
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(3),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        //color: Theme.of(context).primaryColorDark,
        color: Colors.black54,
      ),
      child: ClipOval(
        child: Image.asset(
          student.profileURL,
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
