import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ggmap/api/rest_api.dart';

import 'geocoding_inf.dart';

class GeocodingPre{
  GeocodingInf inf;
  BuildContext context;

  GeocodingPre(this.inf, this.context);
  final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
   getDataGeocoding(String placeid,String language) async{
   await client.getGeocoding('AIzaSyD-phnU4Ri7Ho1cue49ziEB79-hrUAV6o8', placeid, language).then((value) {
      if(value.status=='OK'){
       for(var i in value.results){
         inf.getGeocoding(i.geometry);
       }
      }
    }).catchError((onError){
      print('error $onError');
   });
  }
}