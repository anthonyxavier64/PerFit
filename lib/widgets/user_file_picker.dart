import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UserFilePicker extends StatefulWidget {
  final Function pickCV;
  final BuildContext ctx;

  UserFilePicker(this.pickCV, this.ctx);

  @override
  _UserFilePickerState createState() => _UserFilePickerState();
}

class _UserFilePickerState extends State<UserFilePicker> {
  File _pickedFile;

  Future<void> _pickFile() async {
    final selectedFile = await FilePicker.getFile(
      allowCompression: true,
    );
    if (selectedFile == null) {
      return;
    }
    setState(() {
      _pickedFile = selectedFile;
    });
    Scaffold.of(widget.ctx).showSnackBar(
      SnackBar(
        content: Text('File selected.'),
        duration: Duration(seconds: 1),
      ),
    );
    widget.pickCV(_pickedFile);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 30),
        IconButton(
          icon: Icon(
            Icons.add_circle_outline,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: _pickFile,
        ),
        SizedBox(width: 100),
        Text(
          _pickedFile == null ? 'No file selected' : 'File has been selected',
        ),
        SizedBox(width: 20),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.grey),
          onPressed: () => setState(
            () {
              _pickedFile = null;
              widget.pickCV(null);
            },
          ),
        )
      ],
    );
  }
}
