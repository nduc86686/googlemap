class GeocodedWaypoints {
  GeocodedWaypoints({
    required this.geocoderStatus,
    required this.placeId,
    required this.types,
  });
  late final String geocoderStatus;
  late final String placeId;
  late final List<String> types;

  GeocodedWaypoints.fromJson(Map<String, dynamic> json){
    geocoderStatus = json['geocoder_status'];
    placeId = json['place_id'];
    types = List.castFrom<dynamic, String>(json['types']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['geocoder_status'] = geocoderStatus;
    _data['place_id'] = placeId;
    _data['types'] = types;
    return _data;
  }
}