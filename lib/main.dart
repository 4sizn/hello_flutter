import 'package:flutter/material.dart';
import 'package:flutter_hello_world/providers/location_provider.dart';
import 'package:flutter_hello_world/screen/login.dart';
import 'package:flutter_hello_world/screen/map.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

void main() => runApp(ChangeNotifierProvider(
    create: (context) => LocationProvider(), child: const MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleSignInAccount? _currentUser;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Login());
  }
}
