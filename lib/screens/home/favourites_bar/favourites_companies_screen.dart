import 'package:flutter/material.dart';

class FavouritesCompaniesScreen extends StatelessWidget {
  static const routeName = '/favourites_companies_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourited Companies'),
      ),
      body: Center(
        child: Text(
          'Your Favourites',
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
