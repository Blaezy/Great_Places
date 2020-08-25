import 'package:flutter/material.dart';
import 'package:great_places/Providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places List'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlace.routeName);
              })
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlaces>(context, listen: false).fetchAndSetData(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<GreatPlaces>(
                    child: Center(child: Text('No Places Added add some!')),
                    builder: (ctx, greatPlace, ch) {
                      return greatPlace.items.length <= 0
                          ? ch
                          : ListView.builder(
                              itemBuilder: (ctx, index) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatPlace.items[index].image),
                                ),
                                title: Text(greatPlace.items[index].title),
                                onTap: () {},
                              ),
                              itemCount: greatPlace.items.length,
                            );
                    },
                  ),
      ),
    );
  }
}
