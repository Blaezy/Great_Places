import 'package:flutter/material.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geocoder/geocoder.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  double lat = 100;
  double long = -74.00;

  Future<void> _getCurrentLoaction() async {
    try {} catch (error) {}
    final locdata = await Location().getLocation();
    setState(() {
      lat = locdata.latitude;
      long = locdata.longitude;
    });
    widget.onSelectPlace(locdata.latitude, locdata.longitude);
  }

  Future<void> _onSelect() async {
    final seelctedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(
                  isSelecting: true,
                )));
    if (seelctedLocation == null) {
      return;
    }
    setState(() {
      lat = seelctedLocation.latitude;
      long = seelctedLocation.longitude;
    });
    widget.onSelectPlace(seelctedLocation.latitude, seelctedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 5, color: Colors.grey)),
          child: lat == 100
              ? Text(
                  'No location Chosen',
                  textAlign: TextAlign.center,
                )
              : new FlutterMap(
                  options: new MapOptions(
                    center: new LatLng(lat, long),
                    zoom: 13.0,
                  ),
                  layers: [
                    new TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']),
                    new MarkerLayerOptions(
                      markers: [
                        new Marker(
                          width: 45.0,
                          height: 45.0,
                          point: new LatLng(lat, long),
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
                onPressed: _getCurrentLoaction,
                icon: Icon(Icons.location_on),
                label: Text(
                  'Current Location',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
            FlatButton.icon(
                onPressed: _onSelect,
                icon: Icon(Icons.map),
                label: Text(
                  'Select on Map',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ))
          ],
        )
      ],
    );
  }
}
