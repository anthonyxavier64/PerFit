import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../chat/message_bubble.dart';

class Messages extends StatelessWidget {
  final uid;
  final bool isEmployer;

  Messages(this.uid, this.isEmployer);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final FirebaseUser currentUser = futureSnapshot.data;
        return StreamBuilder(
          stream: this.isEmployer
              ? Firestore.instance
                  .collection('employers')
                  .document(currentUser.uid)
                  .collection('chats')
                  .document(this.uid)
                  .collection('messages')
                  .orderBy(
                    'createdAt',
                    descending: true,
                  )
                  .snapshots()
              : Firestore.instance
                  .collection('students')
                  .document(currentUser.uid)
                  .collection('chats')
                  .document(this.uid)
                  .collection('messages')
                  .orderBy(
                    'createdAt',
                    descending: true,
                  )
                  .snapshots(),
          builder: (ctx, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatDocs = chatSnapshot.data.documents;
            return ListView.builder(
              reverse: true,
              itemBuilder: (ctx, index) => MessageBubble(
                chatDocs[index]['text'],
                chatDocs[index]['userId'] == futureSnapshot.data.uid,
                key: ValueKey(chatDocs[index].documentID),
              ),
              itemCount: chatDocs.length,
            );
          },
        );
      },
    );
  }
}
