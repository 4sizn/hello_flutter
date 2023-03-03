import 'package:flutter/material.dart';
import 'package:flutter_hello_world/providers/location_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
    create: (context) => LocationProvider(), child: const MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late GoogleMapController mapController;
  GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance = GoogleMapsPlugin();

  final LatLng _center = const LatLng(45.521563, -122.677433);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return MaterialApp(
      home: Scaffold(
          body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {},
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
          Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.transparent,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Material(
                    color: Colors.transparent,
                    child: Center(
                        child: Ink(
                            decoration: const ShapeDecoration(
                              color: Colors.lightBlue,
                              shape: CircleBorder(),
                            ),
                            child: TextButton(
                                child: const Text(
                                  '+',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                                onPressed: () {}))),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Center(
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.lightBlue,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.replay),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  )
                ]),
              ))
        ],
      )),
    );
  }
}
