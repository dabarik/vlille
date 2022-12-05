import 'dart:async';
import 'package:flutter/material.dart';
import 'package:api_vliil/main.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class detailPage extends StatelessWidget {
  static const IconData location_on = IconData(
    0xe3ab,
    fontFamily: 'MaterialIcons',
  );

  final double longitude;
  final double latitude;
  final String nom;

  detailPage(
      {required this.longitude,
      required this.latitude,
      required this.nom,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Station : $nom")),
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(latitude, longitude),
            zoom: 16,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(latitude, longitude),
                  width: 80,
                  height: 80,
                  builder: (context) => const Icon(
                    location_on,
                    size: 50.0,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}