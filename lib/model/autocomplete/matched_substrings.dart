class MatchedSubstrings {
  MatchedSubstrings({
    required this.length,
    required this.offset,
  });
  late final int length;
  late final int offset;

  MatchedSubstrings.fromJson(Map<String, dynamic> json){
    length = json['length'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['length'] = length;
    _data['offset'] = offset;
    return _data;
  }
}