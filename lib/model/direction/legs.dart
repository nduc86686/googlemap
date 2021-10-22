import 'package:ggmap/model/direction/start_location.dart';
import 'package:ggmap/model/direction/steps.dart';
import 'package:ggmap/model/direction/duration.dart';
import 'distance.dart';
import 'endLocation.dart';

class Legs {
  Legs({
    required this.distance,
    required this.duration,
    required this.endAddress,
    required this.endLocation,
    required this.startAddress,
    required this.startLocation,
    required this.steps,
    required this.trafficSpeedEntry,
    required this.viaWaypoint,
  });
  late final Distance distance;
  late final Duration duration;
  late final String endAddress;
  late final EndLocation endLocation;
  late final String startAddress;
  late final StartLocation startLocation;
  late final List<Steps> steps;
  late final List<dynamic> trafficSpeedEntry;
  late final List<dynamic> viaWaypoint;

  Legs.fromJson(Map<String, dynamic> json){
    distance = Distance.fromJson(json['distance']);
    duration = Duration.fromJson(json['duration']);
    endAddress = json['end_address'];
    endLocation = EndLocation.fromJson(json['end_location']);
    startAddress = json['start_address'];
    startLocation = StartLocation.fromJson(json['start_location']);
    steps = List.from(json['steps']).map((e)=>Steps.fromJson(e)).toList();
    trafficSpeedEntry = List.castFrom<dynamic, dynamic>(json['traffic_speed_entry']);
    viaWaypoint = List.castFrom<dynamic, dynamic>(json['via_waypoint']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['distance'] = distance.toJson();
    _data['duration'] = duration.toJson();
    _data['end_address'] = endAddress;
    _data['end_location'] = endLocation.toJson();
    _data['start_address'] = startAddress;
    _data['start_location'] = startLocation.toJson();
    _data['steps'] = steps.map((e)=>e.toJson()).toList();
    _data['traffic_speed_entry'] = trafficSpeedEntry;
    _data['via_waypoint'] = viaWaypoint;
    return _data;
  }
}