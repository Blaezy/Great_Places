import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/Models/places.dart';
import 'package:great_places/Providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlace extends StatefulWidget {
  static const routeName = '/add-Place';
  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _textController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectedImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void selectPlace(double lat, double long) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: long);
  }

  void _saveForm() {
    if (_textController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_textController.text, _pickedImage, _pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add A Place')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    controller: _textController,
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ImageInput(_selectedImage),
                  SizedBox(height: 10),
                  LocationInput(selectPlace),
                ],
              ),
            ),
          )),
          FlatButton.icon(
            onPressed: _saveForm,
            color: Theme.of(context).accentColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
          )
        ],
      ),
    );
  }
}
