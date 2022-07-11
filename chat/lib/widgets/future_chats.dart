import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/firestore_collections/chat_collection.dart';
import '../models/chat_model.dart';
import 'message_bubble.dart';

class FutureChats extends StatelessWidget {
  // final UserModel userModel; voobshe kerek emes
  final String currentUserId;
  const FutureChats({
    // @required this.userModel,
    @required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: chatsCollection.get(), // serverdegi polniy tizmeni beret
      // tizmeni alip alip snapshotDannyi menen ishteshebiz
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshotDannyi) {
        if (snapshotDannyi.hasData) {
          final _chatTizmeData = snapshotDannyi.data.docs;
          return Expanded(
            child: ListView.builder(
              shrinkWrap:
                  true, // Columndun ichinde ListViewnu koldongondo shrinkWrap true dep koiso problema jok
              itemCount: _chatTizmeData.length ?? 0,
              // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              // listview builder tizmeni tizip korsotkongo
              itemBuilder: (context, index) {
                ChatModel _chat =
                    ChatModel.fromJson(_chatTizmeData[index].data());
                log('_chat===>$_chat');
                return MessageBubble(
                  // isMe: userModel.id == currentUserId,
                  isMe: _chat.senderId == currentUserId,
                  email: _chat.senderEmail,
                  text: _chat.message,
                );
              },
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
