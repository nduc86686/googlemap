class AddressComponents {
  AddressComponents({
    required this.longName,
    required this.shortName,
    required this.types,
  });
  late final String longName;
  late final String shortName;
  late final List<String> types;

  AddressComponents.fromJson(Map<String, dynamic> json){
    longName = json['long_name'];
    shortName = json['short_name'];
    types = List.castFrom<dynamic, String>(json['types']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['long_name'] = longName;
    _data['short_name'] = shortName;
    _data['types'] = types;
    return _data;
  }
}