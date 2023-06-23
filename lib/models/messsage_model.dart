import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  
  Message ({
    required this.senderEmail,
    required this.senderId,
    required this.message,
    required this.receiverId,
    required this.timestamp,
  });


  Map<String, dynamic> toMap(){
    return  {
      "senderId":senderId,
      "senderEmail":senderEmail,
       "receiverId":receiverId,
       "message":message,
       "timeStamp":timestamp,
  };
}

}