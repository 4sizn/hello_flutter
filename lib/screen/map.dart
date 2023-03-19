import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hello_world/providers/location_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:provider/provider.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<Maps> {
  // GoogleMapsFlutterPlatform mapsImplementation =
  //     GoogleMapsFlutterPlatform.instance = GoogleMapsPlugin();

  @override
  void initState() {
    super.initState();

    Future.microtask(() => context.read<LocationProvider>().getLocation());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    GoogleMapController mapControler;
    Completer<GoogleMapController> _controller = Completer();

    void animatedViewofMap({double? lat, double? lng}) async {
      CameraPosition cPosition = CameraPosition(
        zoom: 15,
        target: LatLng(lat!, lng!),
      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    }

    return Scaffold(
        body: Consumer(builder: (context, LocationProvider provider, _) {
      if (provider.status == LocationProviderStatus.initial ||
          provider.status == LocationProviderStatus.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (provider.status == LocationProviderStatus.success) {
        LocationProvider locationProvider =
            Provider.of<LocationProvider>(context);

        CameraPosition initialCameraPosition = CameraPosition(
            target: LatLng(locationProvider.userLocation.latitude,
                locationProvider.userLocation.longitude),
            zoom: 15);

        animatedViewofMap(
            lat: locationProvider.userLocation.latitude,
            lng: locationProvider.userLocation.longitude);
        return Stack(
          children: [
            GoogleMap(
              mapType: MapType.terrain,
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: initialCameraPosition,
            ),
            Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Material(
                              color: Colors.transparent,
                              child: Center(
                                child: Ink(
                                  padding: EdgeInsets.all(10),
                                  decoration: const ShapeDecoration(
                                    color: Colors.lightBlue,
                                    shape: CircleBorder(),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.edit_location_alt),
                                    color: Colors.white,
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Material(
                              color: Colors.transparent,
                              child: Center(
                                child: Ink(
                                  padding: EdgeInsets.all(10),
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
                            ))
                      ]),
                )),
            Positioned(
                left: 50,
                bottom: 20,
                child: Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Material(
                      color: Colors.transparent,
                      child: Center(
                        child: Ink(
                          padding: EdgeInsets.all(10),
                          decoration: const ShapeDecoration(
                            color: Colors.lightBlue,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_outward_sharp),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    )))
          ],
        );
      } else {
        return const Center(child: Text('error'));
      }
    }));
  }
}
