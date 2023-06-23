import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:scrapingdart/main.dart';
import 'package:flutter/material.dart';
import 'package:scrapingdart/models/message.dart';
import 'package:scrapingdart/models/messsage_model.dart';



class ChatServices extends GetxController {

  
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

Future<void> sendMessage(String receiverId,String message)async {
  final String userid = _firebaseAuth.currentUser!.uid;
  final String userEmail  = _firebaseAuth.currentUser!.email.toString();
  final Timestamp timestamp = Timestamp.now();


Message newMessage = Message(message:message, receiverId: receiverId, senderEmail: userEmail, senderId: userid, timestamp: timestamp
  
);

List<String> ids = [userid,receiverId];

ids.sort();

String chatRoomId =  ids.join("_");

await FirebaseFirestore.instance.collection("chat_room").doc(chatRoomId).collection("message").add(newMessage.toMap());


}



}