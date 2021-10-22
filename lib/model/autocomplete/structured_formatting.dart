import 'main_text_matched_substrings.dart';

class StructuredFormatting {
  StructuredFormatting({
    required this.mainText,
    required this.mainTextMatchedSubstrings,
    required this.secondaryText,
  });
  late final String mainText;
  late final List<MainTextMatchedSubstrings> mainTextMatchedSubstrings;
  late final String secondaryText;

  StructuredFormatting.fromJson(Map<String, dynamic> json){
    mainText = json['main_text'];
    mainTextMatchedSubstrings = List.from(json['main_text_matched_substrings']).map((e)=>MainTextMatchedSubstrings.fromJson(e)).toList();
    secondaryText = json['secondary_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['main_text'] = mainText;
    _data['main_text_matched_substrings'] = mainTextMatchedSubstrings.map((e)=>e.toJson()).toList();
    _data['secondary_text'] = secondaryText;
    return _data;
  }
}