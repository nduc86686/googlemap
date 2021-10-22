import 'package:ggmap/model/direction/routes.dart';

import 'geocoded_waypoints.dart';

class DirectionData {
  DirectionData({
    required this.geocodedWaypoints,
    required this.routes,
    required this.status,
  });
  late final List<GeocodedWaypoints> geocodedWaypoints;
  late final List<Routes> routes;
  late final String status;

  DirectionData.fromJson(Map<String, dynamic> json){
    geocodedWaypoints = List.from(json['geocoded_waypoints']).map((e)=>GeocodedWaypoints.fromJson(e)).toList();
    routes = List.from(json['routes']).map((e)=>Routes.fromJson(e)).toList();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['geocoded_waypoints'] = geocodedWaypoints.map((e)=>e.toJson()).toList();
    _data['routes'] = routes.map((e)=>e.toJson()).toList();
    _data['status'] = status;
    return _data;
  }
}









