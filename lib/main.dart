import 'package:flutter/material.dart';
import 'package:flutter_hello_world/providers/location_provider.dart';
import 'package:flutter_hello_world/ui/map.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
    create: (context) => LocationProvider(), child: const MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Maps());
  }
}
