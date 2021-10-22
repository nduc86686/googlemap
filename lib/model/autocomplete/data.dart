import 'package:ggmap/model/autocomplete/predictions.dart';

class Data {
  Data({
    required this.predictions,
    required this.status,
  });
  late final List<Predictions> predictions;
  late final String status;

  Data.fromJson(Map<String, dynamic> json){
    predictions = List.from(json['predictions']).map((e)=>Predictions.fromJson(e)).toList();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['predictions'] = predictions.map((e)=>e.toJson()).toList();
    _data['status'] = status;
    return _data;
  }
}






