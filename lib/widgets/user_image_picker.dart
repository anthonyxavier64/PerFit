import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function pickImage;
  final BuildContext ctx;

  UserImagePicker(this.pickImage, this.ctx);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 150,
      imageQuality: 50,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _pickedImage = File(imageFile.path);
    });
    Scaffold.of(widget.ctx).showSnackBar(
      SnackBar(
        content: Text('Image selected.'),
        duration: Duration(seconds: 1),
      ),
    );
    widget.pickImage(_pickedImage);
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
          onPressed: _pickImage,
        ),
        SizedBox(width: 100),
        CircleAvatar(
          radius: 42,
          backgroundColor: Theme.of(context).primaryColor,
          child: CircleAvatar(
            radius: 40,
            backgroundImage:
                _pickedImage == null ? null : FileImage(_pickedImage),
            backgroundColor: Theme.of(context).accentColor,
          ),
        ),
        SizedBox(width: 20),
        IconButton(
            icon: Icon(Icons.delete, color: Colors.grey),
            onPressed: () {
              setState(() {
                _pickedImage = null;
                widget.pickImage(null);
              });
            })
      ],
    );
  }
}
