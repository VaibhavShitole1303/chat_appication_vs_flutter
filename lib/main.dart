import 'package:chat_appication_vs/services/auth/auth_gate.dart';
import 'package:chat_appication_vs/services/auth/firebase_auth_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //initialize firebase from fire core plugin
  await Firebase.initializeApp();
  runApp(
ChangeNotifierProvider(create: (create)=>FireBaseAuthService(),
child:  MyApp(),)  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}
