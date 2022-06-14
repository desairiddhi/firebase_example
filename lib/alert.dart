import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'main.dart';

class MyAlert extends StatefulWidget {
  const MyAlert({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<MyAlert> createState() => _MyAlertState();
}

class _MyAlertState extends State<MyAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(
              width: double.infinity,
              child: Text(
                "Are You Sure you want to delete?",
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyApp()));

            FirebaseFirestore.instance
                .collection('task')
                .doc(widget.id)
                .delete();
          },                                      
          child: const Text(
            "Delete",
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyApp()));
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
