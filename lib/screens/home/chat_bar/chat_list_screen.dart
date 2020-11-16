import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../widgets/loading.dart';
import '../../home/chat_bar/chat_screen.dart';
import '../../../models/chat.dart';

class ChatListScreen extends StatelessWidget {
  static const routeName = './chatListScreen';
  final bool isEmployer;
  final DocumentSnapshot currentUser;
  final bool notSignedIn;

  ChatListScreen(this.isEmployer, this.currentUser, this.notSignedIn);

  @override
  Widget build(BuildContext context) {
    return notSignedIn
        ? Center(
            child: Text(
              'Please log in / sign up to enjoy this feature.',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          )
        : StreamBuilder(
            stream: isEmployer
                ? Firestore.instance
                    .collection('employers')
                    .document(currentUser.documentID)
                    .collection('chats')
                    .orderBy('createdAt')
                    .snapshots()
                : Firestore.instance
                    .collection('students')
                    .document(currentUser.documentID)
                    .collection('chats')
                    .orderBy('createdAt')
                    .snapshots(),
            builder: (ctx, snapshots) {
              if (snapshots.connectionState == ConnectionState.waiting) {
                return Loading();
              }
              return snapshots.data.documents.length <= 0
                  ? Center(
                      child: Text(
                        isEmployer
                            ? 'No chat found. Send offers and start chatting!'
                            : 'No chat found. Accept offers and start chatting!',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: snapshots.data.documents.length,
                      itemBuilder: (ctx, index) {
                        String imageUrl =
                            snapshots.data.documents[index]['imageUrl'];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              ChatScreen.routeName,
                              arguments: Chat(
                                snapshots.data.documents[index].documentID,
                                snapshots.data.documents[index]['name'],
                                isEmployer,
                                imageUrl,
                              ),
                            );
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 42,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundImage: imageUrl != ''
                                          ? NetworkImage(imageUrl)
                                          : null,
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          snapshots.data.documents[index]
                                              ['name'],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          snapshots.data.documents[index]
                                              ['text'],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
            },
          );
  }
}
