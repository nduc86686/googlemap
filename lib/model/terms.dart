class Terms {
  Terms({
    required this.offset,
    required this.value,
  });
  late final int offset;
  late final String value;

  Terms.fromJson(Map<String, dynamic> json){
    offset = json['offset'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['offset'] = offset;
    _data['value'] = value;
    return _data;
  }
}