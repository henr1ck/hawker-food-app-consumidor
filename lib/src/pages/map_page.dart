import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:hawker_food/src/models/hawker.dart';
import 'package:hawker_food/src/services/hawker_service.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late Future<Hawker> futureHawker1;
  late Future<Hawker> futureHawker2;

  int _index = 0;

  @override
  void initState() {
    super.initState();
    // futureHawker1 = HawkerService().fetchHawker(1);
    // futureHawker2 = HawkerService().fetchHawker(2);
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 42, 42, 42),
      body: FutureBuilder(
        future: _determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "${snapshot.error}",
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (snapshot.hasData) {
            Position position = snapshot.data!;
            return FlutterMap(
              options: MapOptions(
                  initialZoom: 16.0,
                  initialCenter: LatLng(position.latitude, position.longitude)),
              children: [
                Builder(
                  builder: (context) {
                    if (MapCamera.of(context).zoom < 12) {
                      return const SizedBox.shrink();
                    }
                    return TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'br.dev.henrick',
                        tileProvider:
                            const FMTCStore('mapStore').getTileProvider());
                  },
                ),
                RichAttributionWidget(
                  // Include a stylish prebuilt attribution widget that meets all requirments
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () => launchUrl(
                        Uri.parse("https://openstreetmap.org/copyright"),
                      ), // (external)
                    ),
                  ],
                ),
                CurrentLocationLayer(
                  alignPositionOnUpdate: AlignOnUpdate.never,
                  alignDirectionOnUpdate: AlignOnUpdate.never,
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map_rounded),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_rounded),
            label: "Pedidos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: "Perfil",
          )
        ],
      ),
    );
  }
}

/*FutureBuilder<Hawker>(
            future: futureHawker1,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      _scaffoldKey.currentContext!,
                      MaterialPageRoute(
                        builder: (context) {
                          return HawkerPage(
                            vendedorId: snapshot.data!.id,
                          );
                        },
                      ),
                    );
                  },
                  child: Text(
                    snapshot.data!.nome,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(
                  '${snapshot.error}',
                  style: const const TextStyle(color: Colors.white),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
          FutureBuilder<Hawker>(
            future: futureHawker2,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      _scaffoldKey.currentContext!,
                      MaterialPageRoute(
                        builder: (context) {
                          return HawkerPage(
                            vendedorId: snapshot.data!.id,
                          );
                        },
                      ),
                    );
                  },
                  child: Text(
                    snapshot.data!.nome,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(
                  '${snapshot.error}',
                  style: const const TextStyle(color: Colors.white),
                );
              }
              return const CircularProgressIndicator();
            },
          ),*/
