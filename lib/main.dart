import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:ggmap/model/direction/direction_data.dart';
import 'package:ggmap/model/geocoding/geometry.dart';
import 'package:ggmap/model/placepicker/data_placepicker.dart';
import 'package:ggmap/request/geocodingpre/geocoding_inf.dart';
import 'package:ggmap/request/geocodingpre/geocoding_pre.dart';
import 'package:ggmap/request/polyline/polyline_inf.dart';
import 'package:ggmap/request/polyline/polyline_pre.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'address_search.dart';
import 'common/textfield.dart';
import 'request/placepicker/placepicker_inf.dart';
import 'request/placepicker/placepicker_pre.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapView(),
    );
  }
}

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView>
    implements GeocodingInf, PolylineInf, PlacePickerInf {
  //permission
  late Permission permission;
  PermissionStatus permissionStatus = PermissionStatus.denied;

  //goole map controller
  late GoogleMapController _googleMapController;

  //controller địa điểm di,
  final _controller = TextEditingController();
  static const _initialCameraPosition = CameraPosition(
    //21.0278, 105.8342
    target: LatLng(21.0278, 105.8342),
    zoom: 15,
  );

  // Marker? _origin;
  // Marker? _destination;
  Marker? markers;
  Marker? destination;

  Geometry? geometry;
  DataPlacePicker? dataplacepicker;
  GeocodingPre? pre;
  PolylinePre? polypre;
  PlacePickerPre? placeickerpre;
  DirectionData? direction_data;
  String? placeid;
  Position? _currentPosition;

  Future<void> requestForPermisson() async {
    final status = await Permission.location.request();
    setState(() {
      permissionStatus = status;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listenForPermisson();
    pre = GeocodingPre(this, context);
    polypre = PolylinePre(this, context);
    placeickerpre = PlacePickerPre(this, context);

    markers = Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(_initialCameraPosition.toString()),
      position: LatLng(21.0186416, 105.848537),
      infoWindow: InfoWindow(
        title: 'Bộ thông tin và truyền thông',
        snippet: 'Văn phòng chính phủ',
      ),
      icon: BitmapDescriptor.defaultMarker,
    );
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.yellow,
        title: Text(
          'Map Demo',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onCameraMove: (CameraPosition newPosition) async {
              // lat: newPosition.target.latitude;
              // lng: newPosition.target.longitude;
              String latlng =
                  '${newPosition.target.latitude},${newPosition.target.longitude}';
              await placeickerpre!.getDataGeocoding(
                  'AIzaSyD-phnU4Ri7Ho1cue49ziEB79-hrUAV6o8',
                  latlng,
                  'ROOFTOP',
                  '',
                  'vi',
                  'vn'); //street_address
              print(
                  'check data ${dataplacepicker!.results![0].formattedAddress}');
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            polylines: {
              if (direction_data != null)
                Polyline(
                    polylineId: PolylineId('overview_polyline'),
                    color: Colors.red,
                    width: 5,
                    points: PolylinePoints()
                        .decodePolyline(
                            direction_data!.routes[0].overviewPolyline.points)
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList()),
            },
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              markers ??
                  Marker(
                    markerId: const MarkerId(''),
                    infoWindow: const InfoWindow(title: ''),
                  ),
              destination ??
                  Marker(
                    markerId: const MarkerId(''),
                    infoWindow: const InfoWindow(title: ''),
                  ),
            },
            // onLongPress: _addMarker,
          ),
          if (direction_data != null)
            Positioned(
              top: 170.0,
              left: 120,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                          '${direction_data!.routes[0].legs[0].distance.text} , '),
                      Text(
                          '${direction_data!.routes[0].legs[0].duration.text}'),
                    ],
                  ),
                ),
              ),
            ),
          if (dataplacepicker != null)
            Positioned(
                bottom: 20.0,
                left: 35,
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        dataplacepicker != null
                            ? Text(
                                '${dataplacepicker!.results![0].formattedAddress}',
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              )
                            : CircularProgressIndicator(),
                        SizedBox(height: 10),
                        RaisedButton(
                          color: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
                            "Select here",
                            style: TextStyle(fontSize: 16),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          onPressed: () {
                            // onPlacePicked!(result);
                            setState(() {
                              _controller.text = dataplacepicker!
                                  .results![0].formattedAddress!;
                              placeid =
                                  '${dataplacepicker!.results![0].geometry!.location!.lat},${dataplacepicker!.results![0].geometry!.location!.lng}';
                              destination = Marker(
                                markerId: const MarkerId('destination'),
                                infoWindow:
                                    const InfoWindow(title: 'Destination'),
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueBlue),
                                position: LatLng(
                                    dataplacepicker!.results![0].geometry!
                                            .location!.lat ??
                                        0.0,
                                    dataplacepicker!.results![0].geometry!
                                            .location!.lng ??
                                        0.0),
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                )),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.place, size: 36, color: Colors.red),
                SizedBox(height: 42),
              ],
            ),
          ),
          Center(
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField.customTextField(
                        focus: false,
                        ontap: () async {
                          await showSearch(
                                  context: context, delegate: AddressSearch())
                              .then((value) async {
                            // pre=GeocodingPre(this,context);
                            await pre!
                                .getDataGeocoding(value['place'], 'vn-vi');
                            _controller.text = value['des'];
                            geometry != null
                                ? print('check 0 null')
                                : print('check null');
                            setState(() {
                              placeid =
                                  '${geometry!.location.lat},${geometry!.location.lng}';
                              _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
                                CameraPosition(
                                    target: LatLng(
                                        geometry!.location.lat, geometry!.location.lng),
                                    zoom: 15.0),
                              ));
                              destination = Marker(
                                markerId: const MarkerId('destination'),
                                infoWindow:
                                    const InfoWindow(title: 'Destination'),
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueBlue),
                                position: LatLng(geometry!.location.lat,
                                    geometry!.location.lng),
                              );
                            });
                          });
                        },
                        controller: _controller,
                        label: 'Địa điểm đi',
                        prefixIcon: Icon(Icons.my_location)),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      color: Colors.amberAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        "Show",
                        style: TextStyle(fontSize: 16),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      onPressed: () async{
                      await polypre!.getRouter(
                            'AIzaSyD-phnU4Ri7Ho1cue49ziEB79-hrUAV6o8',
                            '21.0186416,105.848537',
                            placeid!);
                      // _googleMapController.animateCamera(
                      //   CameraUpdate.zoomTo(14),
                      // );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () {
          _getCurrentLocation();
          _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(
                    _currentPosition!.latitude, _currentPosition!.longitude),
                zoom: 20.0),
          ));
        },
        child: const Icon(Icons.location_on_outlined),
      ),
    ));
  }

  // void _addMarker(LatLng pos) async {
  //   if (_origin == null || (_origin != null && _destination != null)) {
  //     setState(() {
  //       _origin = Marker(
  //         markerId: const MarkerId('origin'),
  //         infoWindow: const InfoWindow(title: 'Origin'),
  //         icon:
  //             BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  //         position: pos,
  //       );
  //       _destination = Marker(
  //         markerId: const MarkerId(''),
  //         infoWindow: const InfoWindow(title: ''),
  //       );
  //     });
  //   } else {
  //     setState(() {
  //       _destination = Marker(
  //         markerId: const MarkerId('destination'),
  //         infoWindow: const InfoWindow(title: 'Destination'),
  //         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //         position: pos,
  //       );
  //     });
  //   }
  // }
  void _listenForPermisson() async {
    final status = await Permission.location.status;
    setState(() {
      permissionStatus = status;
    });
    switch (status) {
      case PermissionStatus.denied:
        requestForPermisson();
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.limited:
        Navigator.pop(context);
        break;
      case PermissionStatus.restricted:
        Navigator.pop(context);
        break;
      case PermissionStatus.permanentlyDenied:
        Navigator.pop(context);
        break;
    }
  }

  _getCurrentLocation() async {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void getGeocoding(Geometry data) {
    // TODO: implement getGeocoding
    if (data != null) {
      setState(() {
        geometry = data;
      });
    }
  }

  @override
  void getRouter(DirectionData data) {
    setState(() {
      direction_data = data;
    });
  }

  @override
  void getPlacePicker(DataPlacePicker data) {
    // TODO: implement getPlacePicker
    setState(() {
      dataplacepicker = data;
    });
  }
}
