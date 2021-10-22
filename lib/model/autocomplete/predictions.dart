import 'package:ggmap/model/autocomplete/structured_formatting.dart';
import 'package:ggmap/model/terms.dart';

import 'matched_substrings.dart';

class Predictions {
  Predictions({
    required this.description,
    required this.matchedSubstrings,
    required this.placeId,
    required this.reference,
    required this.structuredFormatting,
    required this.terms,
    required this.types,
  });
  late final String description;
  late final List<MatchedSubstrings> matchedSubstrings;
  late final String placeId;
  late final String reference;
  late final StructuredFormatting structuredFormatting;
  late final List<Terms> terms;
  late final List<String> types;

  Predictions.fromJson(Map<String, dynamic> json){
    description = json['description'];
    matchedSubstrings = List.from(json['matched_substrings']).map((e)=>MatchedSubstrings.fromJson(e)).toList();
    placeId = json['place_id'];
    reference = json['reference'];
    structuredFormatting = StructuredFormatting.fromJson(json['structured_formatting']);
    terms = List.from(json['terms']).map((e)=>Terms.fromJson(e)).toList();
    types = List.castFrom<dynamic, String>(json['types']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['description'] = description;
    _data['matched_substrings'] = matchedSubstrings.map((e)=>e.toJson()).toList();
    _data['place_id'] = placeId;
    _data['reference'] = reference;
    _data['structured_formatting'] = structuredFormatting.toJson();
    _data['terms'] = terms.map((e)=>e.toJson()).toList();
    _data['types'] = types;
    return _data;
  }
}