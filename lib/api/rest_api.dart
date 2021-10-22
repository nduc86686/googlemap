
import 'package:dio/dio.dart';
import 'package:ggmap/model/autocomplete/data.dart';
import 'package:ggmap/model/direction/direction_data.dart';
import 'package:ggmap/model/geocoding/geocodingdata.dart';
import 'package:ggmap/model/placepicker/data_placepicker.dart';
import 'package:retrofit/retrofit.dart';
part 'rest_api.g.dart';
@RestApi(baseUrl: "https://maps.googleapis.com/maps/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;
  @GET("/api/place/autocomplete/json")
  Future<Data> getData(
      @Query('key') String key,
      @Query('input') String input,
      @Query('components') String components,
      @Query('types') String types,
      @Query('language') String language,
      );

  //get theo place_id
  @GET("/api/geocode/json")
  Future<Geocoding> getGeocoding(
      @Query('key') String key,
      @Query('place_id') String placeid,
      @Query('language') String language,
      );
  //chi đường
  @GET("/api/directions/json")
  Future<DirectionData> getPolyline(
      @Query('key') String key,
      @Query('destination') String destination,
      @Query('origin') String origin,
      );
  //placepicker googlemap
  @GET("/api/geocode/json")
  Future<DataPlacePicker> getPlacePicker(
      @Query('key') String key,
      @Query('latlng') String latlng,
      @Query('location_type') String locationType,
      @Query('result_type') String resultType,
      @Query('language') String language,
      @Query('region') String region,
      );

}


