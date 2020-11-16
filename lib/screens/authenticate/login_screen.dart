import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './registration/employer_registration/employer_registration_screen.dart';
import './registration/student_registration/student_registration_screen.dart';
import './forgot_password_screen.dart';
import '../../services/auth.dart';
import '../home/tabs_screen.dart';
import '../../widgets/loading.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  bool _loading = false;

  Widget _buildLoginField({
    String hintText,
    bool obscure,
    BuildContext context,
    Function function,
    String initValue,
    TextInputType textInputType = TextInputType.text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 70.0),
      child: TextFormField(
        initialValue: initValue,
        obscureText: obscure,
        autocorrect: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).primaryColorDark,
          ),
          errorStyle: TextStyle(color: Colors.red[900]),
        ),
        onChanged: function,
        keyboardType: textInputType,
      ),
    );
  }

  Widget _buildNavigationHomepageButton(
      BuildContext context, String text, Function function) {
    return SizedBox(
      width: 110,
      height: 40,
      child: FlatButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(fontSize: 15),
        ),
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        textColor: Theme.of(context).primaryColorDark,
      ),
    );
  }

  Widget _buildNavigateRegistrationButton(
      BuildContext context, String accountType, Function function) {
    return FlatButton(
      child: Text(
        accountType,
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      textColor: Theme.of(context).accentColor,
      onPressed: function,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body: Builder(
          builder: (ctx) => SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Center(
                  child: Text(
                    'PerFit!',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 45,
                          color: Theme.of(context).accentColor,
                          fontFamily: 'Pacifico',
                        ),
                  ),
                ),
                SizedBox(height: 25),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildLoginField(
                        initValue: _email,
                        hintText: 'email',
                        context: context,
                        obscure: false,
                        textInputType: TextInputType.emailAddress,
                        function: (val) {
                          setState(() {
                            _email = val;
                            print(_email);
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      Stack(
                        children: [
                          _buildLoginField(
                            initValue: _password,
                            hintText: 'password',
                            context: context,
                            obscure: true,
                            function: (val) {
                              setState(() {
                                _password = val;
                                print(_password);
                              });
                            },
                          ),
                          Positioned(
                            right: 30,
                            child: _loading
                                ? CircularProgressIndicator(
                                    strokeWidth: 1,
                                  )
                                : IconButton(
                                    icon: Icon(Icons.arrow_forward),
                                    color: Theme.of(context).accentColor,
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          _loading = true;
                                        });
                                        try {
                                          await _auth
                                              .signInWithEmailAndPassword(
                                                  _email.trim(),
                                                  _password.trim());
                                          print('signing in');
                                        } catch (error) {
                                          setState(
                                            () {
                                              _loading = false;
                                            },
                                          );
                                          var errorMessage =
                                              'Please key in proper credentials.';
                                          print(error.toString());
                                          if (error.toString().contains(
                                              'ERROR_INVALID_EMAIL')) {
                                            errorMessage = 'Invalid email.';
                                          }
                                          if (error.toString().contains(
                                              'ERROR_USER_NOT_FOUND')) {
                                            errorMessage = 'User not found.';
                                          }
                                          if (error.toString().contains(
                                              'ERROR_WRONG_PASSWORD')) {
                                            errorMessage =
                                                'Incorrect password.';
                                          }
                                          Scaffold.of(ctx).showSnackBar(
                                            SnackBar(
                                              content: Text(errorMessage),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 25,
                //   child: FlatButton(
                //     child: Text(
                //       'Forgot password?',
                //       style: TextStyle(
                //         color: Theme.of(context).accentColor,
                //         decoration: TextDecoration.underline,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     onPressed: () async {
                //       setState(() {
                //         _loading = true;
                //       });
                //       await Navigator.of(context)
                //           .pushNamed(ForgotPasswordPage.routeName);
                //       setState(() {
                //         _loading = false;
                //       });
                //     },
                //   ),
                // ),
                SizedBox(height: 30),
                Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Not a member yet?',
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Let\'s explore',
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                      SizedBox(height: 15),
                      _buildNavigationHomepageButton(
                        context,
                        'Student',
                        () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TabsScreen(
                                isEmployerWidget: false,
                                notSignedIn: true,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 15),
                      _buildNavigationHomepageButton(context, 'Employer', () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TabsScreen(
                              isEmployerWidget: true,
                              notSignedIn: true,
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: 25),
                      Text(
                        'or',
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _buildNavigateRegistrationButton(
                          context, 'create student account', () {
                        Navigator.of(context)
                            .pushNamed(StudentRegistrationPage.routeName);
                      }),
                      _buildNavigateRegistrationButton(
                          context, 'create employer account', () {
                        Navigator.of(context)
                            .pushNamed(EmployerRegistrationPage.routeName);
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
