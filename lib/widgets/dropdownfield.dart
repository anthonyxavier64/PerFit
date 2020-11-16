import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final dynamic value;
  final Function onChanged;
  final List<DropdownMenuItem<dynamic>> items;
  final String hintText;

  CustomDropdownField({this.value, this.onChanged, this.items, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 150),
      child: DropdownButtonFormField(
        validator: (val) {
          if (val == null) {
            return 'Please select one';
          }
          return null;
        },
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.red),
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
        value: value,
        isExpanded: true,
        hint: Text(
          hintText,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onChanged: onChanged,
        items: items,
      ),
    );
  }
}
