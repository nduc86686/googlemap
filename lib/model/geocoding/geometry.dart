
import 'package:ggmap/model/geocoding/viewport.dart';

import 'bounds.dart';
import 'location.dart';

class Geometry {
  Geometry({
    required this.bounds,
    required this.location,
    required this.locationType,
    required this.viewport,
  });
  late final Bounds bounds;
  late final Location location;
  late final String locationType;
  late final Viewport viewport;

  Geometry.fromJson(Map<String, dynamic> json){
    bounds = Bounds.fromJson(json['bounds']);
    location = Location.fromJson(json['location']);
    locationType = json['location_type'];
    viewport = Viewport.fromJson(json['viewport']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bounds'] = bounds.toJson();
    _data['location'] = location.toJson();
    _data['location_type'] = locationType;
    _data['viewport'] = viewport.toJson();
    return _data;
  }
}