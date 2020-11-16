import 'package:flutter/material.dart';

class FavouriteItem {
  String name;

  FavouriteItem(this.name);
}

class Favourites with ChangeNotifier {
  Map<String, FavouriteItem> _favourites = {};
}
