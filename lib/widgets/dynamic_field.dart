import 'package:flutter/material.dart';

import './textfield.dart';

class DynamicField extends StatefulWidget {
  final String labelText;
  final Function deleteField;
  final List list;
  final String id;
  final dynamic item;
  final Function function;
  final bool enableText;

  const DynamicField({
    @required this.function,
    @required this.item,
    Key key,
    @required this.labelText,
    @required this.id,
    @required this.deleteField,
    @required this.list,
    this.enableText = true,
  }) : super(key: key);

  @override
  _DynamicFieldState createState() => _DynamicFieldState();
}

class _DynamicFieldState extends State<DynamicField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            CustomTextField(
              initValue: widget.item,
              labelText: widget.labelText,
              marginRight: 50.0,
              marginLeft: 0.0,
              obscure: false,
              enableText: widget.enableText,
              function: widget.function,
            ),
            Positioned(
              right: 0,
              top: 10,
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                onPressed: () {
                  print(this.widget.id);
                  widget.deleteField(this.widget.list, this.widget.id);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
