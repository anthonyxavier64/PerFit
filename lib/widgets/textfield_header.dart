import 'package:flutter/material.dart';

class TextFieldHeader extends StatelessWidget {
  const TextFieldHeader({
    Key key,
    @required this.context,
    @required this.header,
  }) : super(key: key);

  final BuildContext context;
  final String header;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 40),
      child: Text(
        header,
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
      ),
    );
  }
}
