import 'package:ggmap/model/direction/start_location.dart';
import 'package:ggmap/model/direction/duration.dart';
import 'distance.dart';
import 'endLocation.dart';
import 'polyline.dart';

class Steps {
  Steps({
    required this.distance,
    required this.duration,
    required this.endLocation,
    required this.htmlInstructions,
    // required this.polyline,
    required this.startLocation,
    required this.travelMode,
  });
  late final Distance distance;
  late final Duration duration;
  late final EndLocation endLocation;
  late final String htmlInstructions;
  // late final Polyline polyline;
  late final StartLocation startLocation;
  late final String? travelMode;

  Steps.fromJson(Map<String, dynamic> json){
    distance = Distance.fromJson(json['distance']);
    duration = Duration.fromJson(json['duration']);
    endLocation = EndLocation.fromJson(json['end_location']);
    htmlInstructions = json['html_instructions'];
    // polyline = json['polyline'];
    startLocation = StartLocation.fromJson(json['start_location']);
    travelMode = json['travel_mode'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['distance'] = distance.toJson();
    _data['duration'] = duration.toJson();
    _data['end_location'] = endLocation.toJson();
    _data['html_instructions'] = htmlInstructions;
    // _data['polyline'] = polyline;
    _data['start_location'] = startLocation.toJson();
    _data['travel_mode'] = travelMode;
    return _data;
  }
}