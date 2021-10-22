import 'package:ggmap/model/geocoding/result.dart';

class Geocoding {
  Geocoding({
    required this.results,
    required this.status,
  });
  late final List<Results> results;
  late final String status;

  Geocoding.fromJson(Map<String, dynamic> json){
    results = List.from(json['results']).map((e)=>Results.fromJson(e)).toList();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['results'] = results.map((e)=>e.toJson()).toList();
    _data['status'] = status;
    return _data;
  }
}











