


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ggmap/model/autocomplete/predictions.dart';
import 'package:ggmap/request/data_inf.dart';

import 'api/rest_api.dart';
import 'model/autocomplete/data.dart';

class AddressSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        tooltip: 'Back',
        icon: Icon(Icons.arrow_back),
    onPressed: () {
    close(context, null);
    },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
    var data;
    // TODO: implement buildSuggestions
     return FutureBuilder(
      // We will put the api call here
      future: client.getData('AIzaSyD-phnU4Ri7Ho1cue49ziEB79-hrUAV6o8', query, 'country:vn', 'address', 'vi-vn') ,
      builder: (context, snapshot) {
         data= snapshot.data;
          return snapshot.hasData?
          ListView.builder(
              itemCount: data.predictions.length,
              itemBuilder: (context, i){
                return ListTile(
                  leading: Icon(Icons.location_on),
                  onTap: (){
                    close(context, {'des':data.predictions[i].description,'place':data.predictions[i].placeId});
                  },
                  title: Text('${data.predictions[i].description}'),
                );
              }):
              Container();
    });

  }

}

