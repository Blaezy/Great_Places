import 'dart:io';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSavedImage;

  ImageInput(this.onSavedImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final selectedImage =
        await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (selectedImage == null) {
      return;
    }
    setState(() {
      _storedImage = selectedImage;
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory(); //Future
    final imagePath = path.basename(selectedImage
        .path); //location where the image is temporarily stored in using that lcation as base name
    final savedImage = await selectedImage.copy('${appDir.path}/$imagePath');
    widget.onSavedImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storedImage == null
              ? Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                )
              : Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        FlatButton.icon(
            onPressed: _takePicture,
            icon: Icon(Icons.camera),
            label: Text(
              'Take Picture',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ))
      ],
    );
  }
}
