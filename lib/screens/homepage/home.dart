import 'package:flutter/material.dart';
import '../../services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PerFit',
          style: Theme.of(context).textTheme.headline1.copyWith(
                fontSize: 20,
                color: Theme.of(context).accentColor,
              ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () async {
              await _auth.signOut();
              print('Signing out...');
            },
          ),
        ],
      ),
      body: Center(child: Text('home')),
    );
  }
}
