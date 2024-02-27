

import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String senderId;
  final String senderEmail;
  final String reciverId;
  final String message;
  final Timestamp timestamp;
  Message({
    required this.senderId,
    required this.senderEmail,
    required this.message,
    required this.reciverId,
    required this.timestamp,
});

  // convert it to map
Map <String ,dynamic> toMap(){
  return {
    'senderId':senderEmail,
    'senderEmail':senderEmail,
    'receiverId':reciverId,
    'message': message,
    'timestamp':timestamp,
  };
}
}