import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  final receiverUid;
  final bool isEmployer;

  NewMessage(this.receiverUid, this.isEmployer);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enteredMessage = '';
  bool _isLoading = false;

  void _sendMessage() async {
    DocumentSnapshot receiverData;
    DocumentSnapshot userData;
    FocusScope.of(context).unfocus();
    var timeStamp = Timestamp.now();
    _controller.clear();
    setState(() {
      _isLoading = true;
    });
    final currentUser = await FirebaseAuth.instance.currentUser();
    if (widget.isEmployer) {
      receiverData = await Firestore.instance
          .collection('students')
          .document(widget.receiverUid)
          .get();
      userData = await Firestore.instance
          .collection('employers')
          .document(currentUser.uid)
          .get();
      Firestore.instance
          .collection('employers')
          .document(currentUser.uid)
          .collection('chats')
          .document(widget.receiverUid)
          .setData(
        {
          'createdAt': timeStamp,
          'name': receiverData['name'],
          'imageUrl': receiverData['profile_image'],
          'text': _enteredMessage
        },
      );
      Firestore.instance
          .collection('employers')
          .document(currentUser.uid)
          .collection('chats')
          .document(widget.receiverUid)
          .collection('messages')
          .document()
          .setData({
        'text': _enteredMessage,
        'createdAt': timeStamp,
        'userId': currentUser.uid,
        'name': userData['name'],
        'userImage': userData['logo'],
      });
      Firestore.instance
          .collection('students')
          .document(widget.receiverUid)
          .collection('chats')
          .document(currentUser.uid)
          .setData(
        {
          'createdAt': timeStamp,
          'name': userData['name'],
          'imageUrl': userData['logo'],
          'text': _enteredMessage
        },
      );
      Firestore.instance
          .collection('students')
          .document(widget.receiverUid)
          .collection('chats')
          .document(currentUser.uid)
          .collection('messages')
          .document()
          .setData({
        'text': _enteredMessage,
        'createdAt': timeStamp,
        'userId': currentUser.uid,
        'name': userData['name'],
        'userImage': userData['logo'],
      });
    } else {
      receiverData = await Firestore.instance
          .collection('employers')
          .document(widget.receiverUid)
          .get();
      userData = await Firestore.instance
          .collection('students')
          .document(currentUser.uid)
          .get();
      Firestore.instance
          .collection('students')
          .document(currentUser.uid)
          .collection('chats')
          .document(widget.receiverUid)
          .setData(
        {
          'createdAt': timeStamp,
          'name': receiverData['name'],
          'imageUrl': receiverData['logo'],
          'text': _enteredMessage
        },
      );
      Firestore.instance
          .collection('students')
          .document(currentUser.uid)
          .collection('chats')
          .document(widget.receiverUid)
          .collection('messages')
          .document()
          .setData({
        'text': _enteredMessage,
        'createdAt': timeStamp,
        'userId': currentUser.uid,
        'name': userData['name'],
        'userImage': userData['profile_image'],
      });
      Firestore.instance
          .collection('employers')
          .document(widget.receiverUid)
          .collection('chats')
          .document(currentUser.uid)
          .setData(
        {
          'createdAt': timeStamp,
          'name': userData['name'],
          'imageUrl': userData['profile_image'],
          'text': _enteredMessage
        },
      );
      Firestore.instance
          .collection('employers')
          .document(widget.receiverUid)
          .collection('chats')
          .document(currentUser.uid)
          .collection('messages')
          .document()
          .setData({
        'text': _enteredMessage,
        'createdAt': timeStamp,
        'userId': currentUser.uid,
        'name': userData['name'],
        'userImage': userData['profile_image'],
      });
    }
    setState(() {
      _isLoading = false;
    });
    // final employerData = await Firestore.instance
    //     .collection('employers')
    //     .document(widget.uid)
    //     .get();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              controller: _controller,
              decoration: InputDecoration(labelText: 'Message'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          _isLoading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                )
              : IconButton(
                  color: Theme.of(context).primaryColor,
                  icon: Icon(
                    Icons.send,
                  ),
                  onPressed:
                      _enteredMessage.trim().isEmpty ? null : _sendMessage,
                ),
        ],
      ),
    );
  }
}
