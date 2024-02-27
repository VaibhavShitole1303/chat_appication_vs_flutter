import 'package:chat_appication_vs/components/chat_bubble.dart';
import 'package:chat_appication_vs/components/my_text_field.dart';
import 'package:chat_appication_vs/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatefulWidget {
  final String receiveruserEmail;
  final String receiverUserID;
  const ChatPage(
      {super.key,
      required this.receiveruserEmail,
      required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      // clear controller after sending message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
      Row(
        children: [
          SizedBox(width: 70,),
          Center(child: Text(widget.receiveruserEmail,textAlign:TextAlign.center,)),
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [Expanded(child: _buildMessageList()), _buildUserInput()],
        ),
      ),
    );
  }
  //build message list
   Widget _buildMessageList(){
    return StreamBuilder(stream: _chatService.getMessage(widget.receiverUserID, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
            if(snapshot.hasError){
              return Text('Error${snapshot.error}');
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Text("Loading...");
            }
            return ListView(
              children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
            );
        },);
   }
  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    //align sender to right and receiver to right
    print((data['senderId'] ));
    print( _firebaseAuth.currentUser!.uid);
    print((data['senderId'] == _firebaseAuth.currentUser!.email));
     bool rl=(data['senderId'] == _firebaseAuth.currentUser!.email);
    var alignment =Alignment.center;
    if(rl){
       alignment=Alignment.centerRight;
    }else{
      alignment=Alignment.centerLeft;
    };
    print((alignment));

    return Container(
      alignment: alignment,
     child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
         crossAxisAlignment:rl? CrossAxisAlignment.end :CrossAxisAlignment.start ,
         children: [
           Text(data['senderEmail']),
           ChatBubble(message: data['message'])

         ],
       ),
     ),);
  }

  //build message input
  Widget _buildUserInput() {
    return Row(
      children: [
        //textfield
        Expanded(
            child: MyTextField(
          controller: _messageController,
          hintText: 'enter message',
          obscureText: false,
        )),
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.send,
            size: 30,
          ),
        )
      ],
    );
  }
}
