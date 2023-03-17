import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final String documentId;
  final Key? key;

  const MapScreen({required this.documentId, this.key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng initialLocation = LatLng(37.7749, -122.4194);
  Set<Marker> markers = Set();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('4S').doc(widget.documentId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            final lat = data['latitude'] as double?;
            final lng = data['longitude'] as double?;
            initialLocation = LatLng(lat ?? 37.7749, lng ?? -122.4194);
            markers.add(
              Marker(
                markerId: MarkerId('Marker'),
                position: initialLocation,
                infoWindow: InfoWindow(title: 'My Location'),
              ),
            );
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: initialLocation,
                zoom: 15,
              ),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              markers: markers,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
