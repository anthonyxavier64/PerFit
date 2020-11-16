import 'package:flutter/material.dart';

import '../../chat/messages.dart';
import '../../chat/new_message.dart';
import '../../../models/chat.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = './chatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final Chat chat = ModalRoute.of(context).settings.arguments;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            chat.name,
            style: Theme.of(context).textTheme.headline2.copyWith(
                  color: Theme.of(context).accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: <Widget>[
            CircleAvatar(
              backgroundImage: (chat.imageUrl != null && chat.imageUrl != '')
                  ? NetworkImage(
                      chat.imageUrl,
                    )
                  : null,
              backgroundColor: Colors.grey[300],
              radius: 30,
            ),
            SizedBox(width: 20),
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                // Expanded makes sure that listview takes as much space as the current screen while making it scrollable
                child: Messages(chat.uid, chat.isEmployer),
              ),
              NewMessage(chat.uid, chat.isEmployer),
            ],
          ),
        ),
      ),
    );
  }
}
