import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:great_places/Models/places.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 37.422, longitude: -122.084),
      this.isSelecting = false});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng pickedLocation;
  void _selectLocation(LatLng position) {
    print('object');
    setState(() {
      pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
        actions: [
          if (widget.isSelecting)
            IconButton(
                icon: Icon(Icons.check),
                onPressed: pickedLocation == null
                    ? null
                    : () {
                        Navigator.of(context).pop(pickedLocation);
                      })
        ],
      ),
      body: new FlutterMap(
        options: new MapOptions(
          center: new LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 16.0,
          onTap: widget.isSelecting ? _selectLocation : null,
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 45.0,
                height: 45.0,
                point: pickedLocation == null
                    ? new LatLng(widget.initialLocation.latitude,
                        widget.initialLocation.longitude)
                    : LatLng(pickedLocation.latitude, pickedLocation.longitude),
                builder: (ctx) => new Container(
                  child: Container(
                    child: IconButton(
                        icon: Icon(Icons.location_on),
                        color: Colors.red,
                        iconSize: 45.0,
                        onPressed: () {}),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
