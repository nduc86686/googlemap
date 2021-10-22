import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ggmap/api/rest_api.dart';

import 'data_inf.dart';

class DataPre{
  DataInf inf;
  BuildContext context;

  DataPre(this.inf, this.context);
  final client = RestClient(Dio(BaseOptions(contentType: "application/json")));

   getData(String key,String input,String components,String types,String language ) async{
  await  client.getData('AIzaSyD-phnU4Ri7Ho1cue49ziEB79-hrUAV6o8', input, components, types, language).
    then((value) =>
        inf.getData(value.predictions)
    );
  }
  

}