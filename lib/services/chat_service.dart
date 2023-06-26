import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:scrapingdart/utils/static_data.dart';
import '../models/message_model.dart';
import '../utils/firebase.dart';

class ChatService {
  FirebaseStorage storage = FirebaseStorage.instance;

  sendMessage(
      Message message, String chatId, recipientName, recipientId) async {
    //will send message to chats collection with the usersId
//admin login kar
    await chatRef.doc(chatId).collection("messages").add(message.toJson());
    //will update "lastTextTime" to the last time a text was sent
   
  await  Future.delayed(Duration(milliseconds: 200),);
    await chatRef.doc(chatId).set({"lastTextTime": Timestamp.now(),
     'user_names':[FirebaseAuth.instance.currentUser!.displayName.toString(),recipientName],
      'users': [recipientId, FirebaseAuth.instance.currentUser!.email],
    
    });
  }

  Future<String> sendFirstMessage(
      {required Message message, recipientId, recipientName}) async {
    DocumentReference ref = await chatRef.add({
      'user_names': [
        StaticData.userDataResponse!.userdata!.name,
        recipientName
      ],
      'users': [recipientId, StaticData.loggedInUserId],
    });
    await sendMessage(message, ref.id, recipientName, recipientId);
    return ref.id;
  }

  Future<String> uploadImage(File image, String chatId) async {
    Reference storageReference =
        storage.ref().child("chats").child(chatId).child(uuid.v4());
    UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.whenComplete(() => null);
    String imageUrl = await storageReference.getDownloadURL();
    return imageUrl;
  }

//determine if a user has read a chat and updates how many messages are unread
  // setUserRead(String chatId, int count) async {
  //   DocumentSnapshot snap = await chatRef.doc(chatId).get();
  //   Map reads = {};

  //   try {
  //     reads = snap.get('reads');
  //   } catch (e) {
  //     reads = {};
  //   }
  //   reads[StaticData.loggedInUserId.toString()] = count;
  //   await chatRef.doc(chatId).update({'reads': reads});
  // }

//determine when a user has start typing a message
  setUserTyping(String chatId, bool userTyping) async {
    DocumentSnapshot snap = await chatRef.doc(chatId).get();
    Map typing = snap.get('typing') ?? {};
    typing[StaticData.userDataResponse!.userdata!.userid] = userTyping;
    await chatRef.doc(chatId).update({
      'typing': typing,
    });
  }

  // Stream<QuerySnapshot> messageListStream(String documentId) {
  //   return chatRef
  //       .doc(documentId)
  //       .collection('messages')
  //       .orderBy('time', descending: true)
  //       .snapshots();
  // }
  Stream<QuerySnapshot> userChatsStream() {
    return chatRef
        .where('users', arrayContains: FirebaseAuth.instance.currentUser!.email)
        .orderBy('lastTextTime', descending: true)
        .snapshots();
     
  }
  //login karo
//admin proper login nai horaha ? firebase auth se ?
// vohi dyk rhu hu
//hrha hy
  Stream<QuerySnapshot> adminsList() {
    return adminsRef
        //firebase kholo

        .snapshots();
  }

  Stream<QuerySnapshot> messageListStream(
      {required String documentId, required bool descending}) {
    return chatRef
        .doc(documentId)
        .collection('messages')
        .orderBy('inserted_at', descending: descending)
        .snapshots();
  }

  Future<String> checkNewChat(userId) async {
    var chatId = "new";

    var chats = await chatRef
        .where('users', arrayContains: StaticData.loggedInUserId)
        .orderBy('lastTextTime', descending: true)
        .get();
    for (var i in chats.docs) {
      List users = i.get("users");
      if (users.contains(userId)) {
        chatId = i.id;
      }
    }
    return chatId;
  }
}
