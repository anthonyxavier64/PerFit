import 'package:flutter/material.dart';
import 'package:perfit_app/providers/companies_list.dart';
import 'package:perfit_app/providers/offers.dart';
import 'package:perfit_app/providers/students_list.dart';
import 'package:perfit_app/screens/company_student_screens/student_details_screen.dart';
import 'package:perfit_app/screens/home/chat_bar/chat_list_screen.dart';
import 'package:perfit_app/screens/home/forum_bar/forum_screen.dart';
import 'package:perfit_app/screens/home/home_bar/offer_status_employer_screen.dart';
import 'package:perfit_app/screens/home/home_bar/offer_status_student_screen.dart';
import 'package:perfit_app/screens/home/chat_bar/chat_screen.dart';
import 'package:perfit_app/screens/home/home_bar/home_screen.dart';
import 'package:perfit_app/screens/home/profile_bar/student_profile_screen.dart';
import 'package:provider/provider.dart';

import './screens/authenticate/forgot_password_screen.dart';
import './screens/authenticate/registration/student_registration/student_registration_screen.dart';
import './screens/authenticate/login_screen.dart';
import './screens/authenticate/registration/employer_registration/employer_registration_screen.dart';
import './screens/authenticate/registration/employer_registration/add_job_screen.dart';
import './services/auth.dart';
import './models/user.dart';
import 'screens/home/home_bar/course_job_screen.dart';
import 'screens/home/home_bar/course_student_screen.dart';
import 'screens/home/favourites_bar/favourited_students_screen.dart';
import 'screens/home/favourites_bar/favourites_companies_screen.dart';
import 'screens/home/tabs_screen.dart';
import './screens/company_student_screens/company_details_screen.dart';
import './screens/home/home_bar/new_companies_screen.dart';
import './screens/home/tabs_screen.dart';
import './wrapper.dart';
import './models/company.dart';
import './screens/home/filter_bar/filter_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /*List<Student> _offerListOfStudents = [];
  List<Company> _favouritedCompanies = [];

  bool _gaveOffer(String studentName) {
    return _offerListOfStudents.any((student) => student.name == studentName);
  }

  void _toggleOffer(String studentName) {
    final existingIndex = _offerListOfStudents
        .indexWhere((student) => student.name == studentName);
    if (existingIndex < 0) {
      setState(() {
        _offerListOfStudents.add(DummyData.DUMMY_STUDENTS
            .firstWhere((student) => student.name == studentName));
      });
    } else {
      setState(() {
        _offerListOfStudents.removeAt(existingIndex);
      });
    }
  }

  bool _isFavourite(String companyId) {
    return _favouritedCompanies.any((company) => company.id == companyId);
  }

  void _toggleFavourites(String companyId) {
    final existingIndex =
        _favouritedCompanies.indexWhere((company) => company.id == companyId);
    if (existingIndex < 0) {
      setState(() {
        _favouritedCompanies.add(DummyData.DUMMY_COMPANIES
            .firstWhere((company) => company.id == companyId));
      });
    } else {
      setState(() {
        _favouritedCompanies.removeAt(existingIndex);
      });
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => CompaniesList(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => StudentsList(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Offers(),
        ),
        //ChangeNotifierProvider(create: (ctx) => Company(),)
      ],
      child: StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Perfit',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.white,
            fontFamily: 'Montserrat',
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                  headline1: TextStyle(
                    //fontFamily: 'Montserrat',
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                  headline2: TextStyle(
                    //fontFamily: 'Montserrat',
                    fontSize: 13,
                    color: Colors.black,
                  ),
                  headline3: TextStyle(
                    fontSize: 11,
                    //fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  headline4: TextStyle(
                    fontSize: 9,
                    //fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  headline5: TextStyle(
                    //fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Colors.black,
                  ),
                  bodyText1: TextStyle(
                    fontSize: 12,
                    //fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  bodyText2: TextStyle(
                    //fontFamily: 'Montserrat',
                    fontSize: 11,
                    color: Colors.black,
                  ),
                ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Wrapper(),
          routes: {
            TabsScreen.routeName: (ctx) => TabsScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            StudentRegistrationPage.routeName: (ctx) =>
                StudentRegistrationPage(),
            EmployerRegistrationPage.routeName: (ctx) =>
                EmployerRegistrationPage(),
            ForgotPasswordPage.routeName: (ctx) => ForgotPasswordPage(),
            AddJobPage.routeName: (ctx) => AddJobPage(),
            Wrapper.routeName: (ctx) => Wrapper(),
            CourseStudentScreen.routeName: (ctx) => CourseStudentScreen(),
            FavouritedStudentsScreen.routeName: (ctx) =>
                FavouritedStudentsScreen(),
            FavouritesCompaniesScreen.routeName: (ctx) =>
                FavouritesCompaniesScreen(),
            NewCompaniesScreen.routeName: (ctx) => NewCompaniesScreen(),
            CompanyDetailsScreen.routeName: (ctx) => CompanyDetailsScreen(),
            OfferStatusEmployerScreen.routeName: (ctx) =>
                OfferStatusEmployerScreen(),
            OfferStatusStudentScreen.routeName: (ctx) =>
                OfferStatusEmployerScreen(),
            StudentDetailsScreen.routeName: (ctx) => StudentDetailsScreen(),
            ChatScreen.routeName: (ctx) => ChatScreen(),
          },
        ),
      ),
    );
  }
}
