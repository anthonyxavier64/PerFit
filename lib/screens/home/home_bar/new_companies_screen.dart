import 'package:flutter/material.dart';

class NewCompaniesScreen extends StatelessWidget {
  static const routeName = './new_companies_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Companies on PerFit'),
      ),
      body: Center(
        child: Text('Companies list comes here'),
      ),
    );
  }
}
