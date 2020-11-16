import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './widgets/loading.dart';
import './screens/authenticate/login_screen.dart';
import './screens/home/tabs_screen.dart';

class Wrapper extends StatelessWidget {
  static const routeName = './wrapper';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }
        if (snapshot.hasData) {
          return TabsScreen();
        }
        return LoginScreen();
      },
    );
  }
}
