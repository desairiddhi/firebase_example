import 'package:flutter/material.dart';

import 'input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title:const Text("Widgets",style: TextStyle(fontFamily: "Tapestry-Regular",fontSize: 20),),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const InputList()));
            },
            title: const Text("Inputs",style: TextStyle(fontSize: 50,fontFamily: 'Tapestry-Regular'),),
          ),
        ],
      ),
    );
  }
}