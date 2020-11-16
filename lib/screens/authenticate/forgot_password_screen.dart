import 'package:flutter/material.dart';
import '../../widgets/textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const routeName = '/forgotPasswordPage';

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String _email;
  bool _emailSent = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PerFit',
          style: Theme.of(context).textTheme.headline1.copyWith(
              fontSize: 20,
              color: Theme.of(context).accentColor,
              fontFamily: 'Pacifico'),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              'We will send a temporary password to you for resetting',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          SizedBox(height: 30),
          Form(
            key: _formKey,
            child: CustomTextField(
              initValue: _email,
              marginRight: 100.0,
              labelText: 'Email',
              obscure: false,
              enableText: true,
              function: (val) {
                _email = val;
                print(_email);
              },
              validator: (val) {
                if (val.isEmpty) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 50),
          SizedBox(
            width: 100,
            child: FlatButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    _emailSent = true;
                    print(_emailSent);
                  });
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Theme.of(context).primaryColor,
              child: Text(
                'Submit',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).accentColor),
              ),
            ),
          ),
          if (_emailSent)
            Text(
              'Email sent!',
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
}
