import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ggmap/api/rest_api.dart';

import 'polyline_inf.dart';

class PolylinePre{
  PolylineInf inf;
  BuildContext context;

  PolylinePre(this.inf, this.context);
  final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
   getRouter(String keykey,String destination,String origin) async{
   await client.getPolyline('AIzaSyD-phnU4Ri7Ho1cue49ziEB79-hrUAV6o8', destination, origin).then((value) => inf.getRouter(value));

  }

}