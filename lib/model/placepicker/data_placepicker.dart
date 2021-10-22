import 'package:ggmap/model/placepicker/pluscode.dart';
import 'package:ggmap/model/placepicker/results.dart';

class DataPlacePicker {
  PlusCode? plusCode;
  List<Results> ?results;
  String ?status;

  DataPlacePicker({this.plusCode, this.results, this.status});

  DataPlacePicker.fromJson(Map<String, dynamic> json) {
    plusCode = json['plus_code'] != null
        ? new PlusCode.fromJson(json['plus_code'])
        : null;
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.plusCode != null) {
      data['plus_code'] = this.plusCode!.toJson();
    }
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}












