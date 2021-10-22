import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ggmap/api/rest_api.dart';
import 'package:ggmap/request/placepicker/placepicker_inf.dart';

class PlacePickerPre{
  PlacePickerInf inf;
  BuildContext context;

  PlacePickerPre(this.inf, this.context);
  final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
   getDataGeocoding(String key,String latlng,String locationType,String resultType,String language,String region) async{
   await client.getPlacePicker(key, latlng, locationType, resultType, language, region).then((value) =>{
      // print('check data ${value.results[0].formattedAddress}'),
     if(value.status=="OK"){
       inf.getPlacePicker(value),
     }
    }
    ).catchError((onError){
      print('error $onError');
   });
  }
}