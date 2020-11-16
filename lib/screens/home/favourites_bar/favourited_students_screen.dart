import 'package:flutter/material.dart';

class FavouritedStudentsScreen extends StatelessWidget {
  static const routeName = '/favourited_student_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Interested Students',
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(color: Colors.white),
        ),
      ),
      body: Center(
        child: Text('students'),
      ),
    );
  }
}
