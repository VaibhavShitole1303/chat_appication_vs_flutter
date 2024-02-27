import 'package:chat_appication_vs/services/auth/firebase_auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/list_background.dart';
import 'chat_page.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // auth instance]
  final FirebaseAuth _auth=FirebaseAuth.instance;
  //sign out user
  void signOut(){
    // get auth service
    final authService=Provider.of<FireBaseAuthService>(context, listen: false);
    authService.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          // sign out button
          IconButton(onPressed:(){
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Confirmation "),
                content: const Text("Do you want to Logout ?"),
                actions: <Widget>[
                  TextButton(
                    onPressed: signOut,
                    child: GestureDetector(

                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        padding: const EdgeInsets.all(14),
                        child: const Text("Yes"
                        ,style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }, icon: const Icon(Icons.logout))
        ],
      ),
      body: _builderUserList(),
    );
  }

  // build a list of users except the current user
 Widget _builderUserList(){
    return StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('users').snapshots(),
    builder: (context, snapshot){
      if(snapshot.hasError){
         return const Text("error");
      }
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Text("Loading..........");
      }
      return ListView(
        children: snapshot.data!.docs.map<Widget>((doc) => _buildUserItem(doc)).toList()
      );
    }
     );
 }

 // build user list item

    Widget _buildUserItem(DocumentSnapshot document){
    Map<String ,dynamic> data= document.data()!  as Map<String,dynamic>;
    // display all user not current user
      if(_auth.currentUser!.email != data['email']){
        return ListTile(
          title:ListBackGround( userName: data['username'],),
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) =>
                ChatPage(receiveruserEmail:data['username'], receiverUserID: data['uid'],),));
          },
        );
      }
      else{
        return Container();
      }

}

}
