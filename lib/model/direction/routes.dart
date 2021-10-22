import 'bounds.dart';
import 'legs.dart';
import 'overview_polyline.dart';

class Routes {
  Routes({
    required this.bounds,
    required this.copyrights,
    required this.legs,
    required this.overviewPolyline,
    required this.summary,
    required this.warnings,
    required this.waypointOrder,
  });
  late final Bounds bounds;
  late final String copyrights;
  late final List<Legs> legs;
  late final OverviewPolyline overviewPolyline;
  late final String summary;
  late final List<dynamic> warnings;
  late final List<dynamic> waypointOrder;

  Routes.fromJson(Map<String, dynamic> json){
    bounds = Bounds.fromJson(json['bounds']);
    copyrights = json['copyrights'];
    legs = List.from(json['legs']).map((e)=>Legs.fromJson(e)).toList();
    overviewPolyline = OverviewPolyline.fromJson(json['overview_polyline']);
    summary = json['summary'];
    warnings = List.castFrom<dynamic, dynamic>(json['warnings']);
    waypointOrder = List.castFrom<dynamic, dynamic>(json['waypoint_order']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bounds'] = bounds.toJson();
    _data['copyrights'] = copyrights;
    _data['legs'] = legs.map((e)=>e.toJson()).toList();
    _data['overview_polyline'] = overviewPolyline.toJson();
    _data['summary'] = summary;
    _data['warnings'] = warnings;
    _data['waypoint_order'] = waypointOrder;
    return _data;
  }
}