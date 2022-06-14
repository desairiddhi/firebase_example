import 'package:flutter/material.dart';

class InputList extends StatefulWidget {
const  InputList({Key? key}) : super(key: key);

  @override
  State<InputList> createState() => _InputListState();
}

class _InputListState extends State<InputList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(),
      body: Center(
        child: TextButton(
          onPressed: (){
            Navigator.pop(context,true);
          },
          child: const Text(" Go Back",style: TextStyle(fontSize: 50,fontFamily: 'Tapestry-Regular')),
      ),
      ),
    );
  }
}