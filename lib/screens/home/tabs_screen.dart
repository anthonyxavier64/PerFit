import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'chat_bar/chat_list_screen.dart';
import './filter_bar/filter_screen.dart';
import './forum_bar/forum_screen.dart';
import './home_bar/home_screen.dart';
import 'profile_bar/student_profile_screen.dart';
import '../../widgets/loading.dart';
import 'profile_bar/employer_profile_screen.dart';
import '../../widgets/home_bar/search/data_search.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabScreen';
  final bool isEmployerWidget;
  final bool notSignedIn;

  TabsScreen({this.isEmployerWidget, this.notSignedIn = false});

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  bool isEmployer = true;
  FirebaseUser currentUser;
  bool _isLoading;
  DocumentSnapshot userData;
  QuerySnapshot searchList;
  var _selectedPageIndex = 0;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _checkIfEmployer();
  }

  Future<void> _checkIfEmployer() async {
    DocumentSnapshot result;
    QuerySnapshot search;
    setState(() {
      _isLoading = true;
    });
    currentUser = await FirebaseAuth.instance.currentUser();
    if (currentUser != null) {
      result = await Firestore.instance
          .collection('employers')
          .document(currentUser.uid)
          .get();
      search = await Firestore.instance.collection('students').getDocuments();
      if (result.exists) {
        isEmployer = true;
        userData = result;
        searchList = search;
        print('success');
      } else {
        isEmployer = false;
        userData = await Firestore.instance
            .collection('students')
            .document(currentUser.uid)
            .get();
        search =
            await Firestore.instance.collection('employers').getDocuments();
        searchList = search;
        print('failure');
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _selectPage(int index) {
    setState(
      () {
        print(isEmployer);
        _selectedPageIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> _pages = [
      {
        'page': !widget.notSignedIn
            ? HomeScreen(isEmployer, userData, widget.notSignedIn)
            : HomeScreen(widget.isEmployerWidget, userData, widget.notSignedIn),
        'title': 'PerFit!'
      },
      {
        'page': FilterScreen(isEmployer, userData, widget.notSignedIn),
        'title': 'Filter'
      },
      {
        'page': ForumScreen(isEmployer, userData, widget.notSignedIn),
        'title': 'Forum'
      },
      {
        'page': ChatListScreen(isEmployer, userData, widget.notSignedIn),
        'title': 'Chat Lists'
      },
      {
        'page': !widget.notSignedIn
            ? !isEmployer
                ? StudentProfileScreen(userData,
                    notSignedIn: widget.notSignedIn)
                : EmployerProfileScreen(userData,
                    notSignedIn: widget.notSignedIn)
            : !widget.isEmployerWidget
                ? StudentProfileScreen(userData,
                    notSignedIn: widget.notSignedIn)
                : EmployerProfileScreen(userData,
                    notSignedIn: widget.notSignedIn),
        'title': 'User Profile'
      },
    ];

    void _onSelect(_) {
      if (!widget.notSignedIn) {
        _auth.signOut();
      } else {
        Navigator.of(context).pop();
      }
    }

    final PreferredSizeWidget mainAppBar = AppBar(
      automaticallyImplyLeading: false,
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print(searchList.documents.length);
              print(isEmployer);
              showSearch(
                  context: context,
                  delegate: DataSearch(searchList, isEmployer));
            }),
        PopupMenuButton(
            onSelected: _onSelect,
            itemBuilder: (ctx) {
              return {!widget.notSignedIn ? 'Sign out' : 'Return to log in'}
                  .map((value) {
                return PopupMenuItem(child: Text(value), value: value);
              }).toList();
            })
      ],
      title: Text(
        _pages[_selectedPageIndex]['title'],
        style: Theme.of(context).textTheme.headline6.copyWith(
              fontFamily: 'Pacifico',
              fontSize: 25,
              color: Colors.white,
            ),
      ),
    );

    final PreferredSizeWidget appBar = AppBar(
      automaticallyImplyLeading: false,
      actions: <Widget>[
        PopupMenuButton(
            onSelected: _onSelect,
            itemBuilder: (ctx) {
              return {!widget.notSignedIn ? 'Sign out' : 'Return to log in'}
                  .map((value) {
                return PopupMenuItem(child: Text(value), value: value);
              }).toList();
            })
      ],
      title: Text(
        _pages[_selectedPageIndex]['title'],
        style: Theme.of(context).textTheme.headline1.copyWith(
              color: Theme.of(context).accentColor,
              fontSize: 25,
            ),
      ),
    );
    /*title: Text(_pages[_selectedPageIndex]['title']),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.undo),
          onPressed: () async {
            await _auth.signOut();
            print('Signing out...');
          },
        ),
      ],*/

    return Scaffold(
      appBar: _selectedPageIndex == 0 ? mainAppBar : appBar,
      body: _isLoading ? Loading() : _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).accentColor,
        selectedItemColor: Colors.blue[900],
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list),
            title: Text('Filter'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            title: Text('Forum'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('Chat'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            //title: Padding(padding: EdgeInsets.all(0)),
          ),
        ],
      ),
    );
  }
}
