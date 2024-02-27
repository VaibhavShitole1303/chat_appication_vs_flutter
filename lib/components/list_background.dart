import 'package:flutter/material.dart';

class ListBackGround extends StatelessWidget {
  final String userName;
  const ListBackGround({super.key,required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey[100]
      ),
      child: Text(userName,
        style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),

    );
  }
}
