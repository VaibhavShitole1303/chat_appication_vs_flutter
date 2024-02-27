

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class FireBaseAuthService extends  ChangeNotifier{
  // this is auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // firestore instance
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;

  Future<User?> signupWithEmailAndPassword(String email,String password,String userName) async{
    try{
      UserCredential credential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // after creating the user , create the new document for this user in th users collection

      _firestore.collection('users').doc(credential.user!.uid).set({
        'username':userName,
        'uid' :credential.user!.uid,
        'email' :email,

      });
      return credential.user;
    }catch(e){
        print("Some Error Occured");
    }
    return null;
  }
  Future<User?> signInWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential credential=await _auth.signInWithEmailAndPassword(email: email, password: password);

      // create the new document for this user in th users collection if its not exist
      _firestore.collection('users').doc(credential.user!.uid).set({
        'uid' :credential.user!.uid,
        'email' :email,
      },SetOptions(merge: true));
      return credential.user;
    }catch(e){
      print("Some Error Occured");
    }
    return null;
  }
  Future<void> signOut() async{
    return await FirebaseAuth.instance.signOut();
  }

}