import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'alert.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);
  final Faker faker = Faker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('task').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshot.data!.docs[index];
                    return ListTile(
                      title: Text(doc['food']),
                      trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: const Center(child: Text("Edit")),
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection('task')
                                  .doc(doc.id)
                                  .update({'food': faker.food.dish()});
                            },
                          ),
                          PopupMenuItem(
                            child: TextButton(
                              onPressed: () async {
                                var res = await showDialog(
                                    context: context,
                                    builder: (context) => MyAlert(id: doc.id));
                              },
                              child: const Center(
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return const Text("No data");
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('task')
              .add({'food': faker.food.dish()});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}


// import 'dart:async';
// // import 'dart:convert' show json;

// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:http/http.dart' as http;

// GoogleSignIn _googleSignIn = GoogleSignIn(
//   // Optional clientId
//   // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
//   scopes: <String>[
//     'email',
//     // 'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );

// void main() {
//   runApp(
//     const MaterialApp(
//       title: 'Google Sign In',
//       home: SignInDemo(),
//     ),
//   );
// }

// class SignInDemo extends StatefulWidget {
//   const SignInDemo({Key? key}) : super(key: key);

//   @override
//   State createState() => SignInDemoState();
// }

// class SignInDemoState extends State<SignInDemo> {
//   GoogleSignInAccount? _currentUser;
//   final String _contactText = '';

//   @override
//   void initState() {
//     super.initState();
//     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
//       setState(() {
//         _currentUser = account;
//       });
//       // if (_currentUser != null) {
//       //   _handleGetContact(_currentUser!);
//       // }
//       print(_currentUser.toString());
//     });
//     _googleSignIn.signInSilently();
//   }

  // Future<void> _handleGetContact(GoogleSignInAccount user) async {
  //   setState(() {
  //     _contactText = 'Loading contact info...';
  //   });
  //   final http.Response response = await http.get(
  //     Uri.parse('https://people.googleapis.com/v1/people/me/connections'
  //         '?requestMask.includeField=person.names'),
  //     headers: await user.authHeaders,
  //   );
  //   if (response.statusCode != 200) {
  //     setState(() {
  //       _contactText = 'People API gave a ${response.statusCode} '
  //           'response. Check logs for details.';
  //     });
  //     print('People API ${response.statusCode} response: ${response.body}');
  //     return;
  //   }
  //   final Map<String, dynamic> data =
  //       json.decode(response.body) as Map<String, dynamic>;
  //   final String? namedContact = _pickFirstNamedContact(data);
  //   setState(() {
  //     if (namedContact != null) {
  //       _contactText = 'I see you know $namedContact!';
  //     } else {
  //       _contactText = 'No contacts to display.';
  //     }
  //   });
  // }

  // String? _pickFirstNamedContact(Map<String, dynamic> data) {
  //   final List<dynamic>? connections = data['connections'] as List<dynamic>?;
  //   final Map<String, dynamic>? contact = connections?.firstWhere(
  //     (dynamic contact) => contact['names'] != null,
  //     orElse: () => null,
  //   ) as Map<String, dynamic>?;
  //   if (contact != null) {
  //     final Map<String, dynamic>? name = contact['names'].firstWhere(
  //       (dynamic name) => name['displayName'] != null,
  //       orElse: () => null,
  //     ) as Map<String, dynamic>?;
  //     if (name != null) {
  //       return name['displayName'] as String?;
  //     }
  //   }
  //   return null;
  // }

//   Future<void> _handleSignIn() async {
//     try {
//       await _googleSignIn.signIn();
//     } catch (error) {
//       print(error);
//     }
//   }

//   Future<void> _handleSignOut() => _googleSignIn.disconnect();

//   Widget _buildBody() {
//     final GoogleSignInAccount? user = _currentUser;
//     if (user != null) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           ListTile(
//             leading: GoogleUserCircleAvatar(
//               identity: user,
//             ),
//             title: Text(user.displayName ?? ''),
//             subtitle: Text(user.email),
//           ),
//           const Text('Signed in successfully.'),
//           Text(_contactText),
//           ElevatedButton(
//             onPressed: _handleSignOut,
//             child: const Text('SIGN OUT'),
//           ),
//           // ElevatedButton(
//           //   child: const Text('REFRESH'),
//           //   onPressed: () => _handleGetContact(user),
//           // ),
//         ],
//       );
//     } else {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           const Text('You are not currently signed in.'),
//           ElevatedButton(
//             onPressed: _handleSignIn,
//             child: const Text('SIGN IN'),
//           ),
//         ],
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Google Sign In'),
//         ),
//         body: ConstrainedBox(
//           constraints: const BoxConstraints.expand(),
//           child: _buildBody(),
//         ));
//   }
// }