import 'address_components.dart';
import 'geometry.dart';

class Results {
  Results({
    required this.addressComponents,
    required this.formattedAddress,
    required this.geometry,
    required this.placeId,
    required this.types,
  });
  late final List<AddressComponents> addressComponents;
  late final String formattedAddress;
  late final Geometry geometry;
  late final String placeId;
  late final List<String> types;

  Results.fromJson(Map<String, dynamic> json){
    addressComponents = List.from(json['address_components']).map((e)=>AddressComponents.fromJson(e)).toList();
    formattedAddress = json['formatted_address'];
    geometry = Geometry.fromJson(json['geometry']);
    placeId = json['place_id'];
    types = List.castFrom<dynamic, String>(json['types']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address_components'] = addressComponents.map((e)=>e.toJson()).toList();
    _data['formatted_address'] = formattedAddress;
    _data['geometry'] = geometry.toJson();
    _data['place_id'] = placeId;
    _data['types'] = types;
    return _data;
  }
}