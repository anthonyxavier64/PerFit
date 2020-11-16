import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double marginRight;
  final bool obscure;
  final bool enableText;
  final Function function;
  final Function validator;
  final double marginLeft;
  final String labelText;
  final TextInputType textInputType;
  final int maxLines;
  final dynamic initValue;

  CustomTextField({
    @required this.marginRight,
    @required this.obscure,
    @required this.enableText,
    @required this.function,
    @required this.initValue,
    this.validator,
    this.marginLeft = 30.0,
    this.labelText = '',
    this.textInputType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: marginLeft, right: marginRight),
      child: TextFormField(
        readOnly: !enableText,
        obscureText: obscure,
        maxLines: maxLines,
        keyboardType: textInputType,
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.red),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        onChanged: function,
        validator: validator,
        initialValue: initValue,
        
      ),
    );
  }
}
