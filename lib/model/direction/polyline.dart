class Polyline {
  Polyline({
    required this.points,
  });
  late final String points;

  Polyline.fromJson(Map<String, dynamic> json){
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['points'] = points;
    return _data;
  }
}