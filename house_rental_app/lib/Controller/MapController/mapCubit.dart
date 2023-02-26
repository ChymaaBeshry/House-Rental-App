
import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:bloc/bloc.dart';
import 'package:newproject/Controller/MapController/mapStates.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:newproject/View/shared_theme/shared_colors.dart';

class MapController extends Cubit<MapStates>{
  MapController() : super(InitialMapState()){
    getUserLocation();
  }

    LatLng _latLng=LatLng(30.033333, 31.233334);
    LatLng get latlng=>_latLng;

    Set<Marker> _markers={};
    Set<Marker> get markers=>_markers;
   Marker? _origin;
   Marker? _destination;
    Placemark? _placeMark;
  Placemark get placeMark=>_placeMark!;
  double distanceBetweenLocations=0;

  LatLng? startLocation;
  LatLng? endLocation;

  List<LatLng> listPolyline=[];
  Map<PolylineId, Polyline> polyLines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyCUwAHVOVv4jIBqltB4-YtJy6WZzZvzS6U";


  getDirections() async {
    emit(LoadingMapState());
 try{
   List<LatLng> polylineCoordinates = [];

   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
     googleAPiKey,
     PointLatLng(startLocation!.latitude, startLocation!.longitude),
     PointLatLng(endLocation!.latitude, endLocation!.longitude),
     travelMode: TravelMode.driving,
   );

   if (result.points.isNotEmpty) {
     emit(SuccessPolyLineState());
     result.points.forEach((PointLatLng point) {
       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
     });
   } else {
     print(result.errorMessage);
   }
   double totalDistance = 0;
   for(var i = 0; i < polylineCoordinates.length-1; i++){
     totalDistance += calculateDistance(
         polylineCoordinates[i].latitude,
         polylineCoordinates[i].longitude,
         polylineCoordinates[i+1].latitude,
         polylineCoordinates[i+1].longitude);
   }
   print(totalDistance);


   distanceBetweenLocations = totalDistance;
   addPolyLine(polylineCoordinates);
   emit(SuccessCurrentLocationState());


 }catch(error){
   emit(ErrorMapState());
   print(error);
 }
  }
  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color:SharedColors.OrangeColor,
      points: polylineCoordinates,
      width: 8,
    );
    polyLines[id] = polyline;

  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }



   double getNearbySpace(double lat, double lng){
     double dis = Geolocator.distanceBetween(_latLng.latitude,_latLng.longitude,lat, lng);
      return dis;
  }





   Future<void> getUserLocation()async{
   try{
     emit(LoadingMapState());
     bool stateLocation=await _checkStateLocation();
     if(stateLocation) {
       Position position = await Geolocator.getCurrentPosition();
       _latLng = LatLng(position.latitude, position.longitude);
       startLocation=_latLng;
       _origin =Marker(
         infoWindow: InfoWindow(title: "Origin" ),
         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
         markerId:MarkerId( _latLng.longitude.toString()),
         position: LatLng(position.latitude, position.longitude),

       );
       _markers.add(_origin!);

       List<Placemark> placeMark = await placemarkFromCoordinates(position.latitude, position.longitude);
        _placeMark=placeMark[0];
       emit(SuccessCurrentLocationState());
     }else{
       emit(ErrorStatusState());
     }

   }catch(error){
     print(error);
     emit(ErrorMapState());
   }
   }

   Future<bool> _checkStateLocation() async{
   LocationPermission permission=await Geolocator.checkPermission();
   if(permission == LocationPermission.denied) {
     permission = await Geolocator.requestPermission();
     if (permission == LocationPermission.denied) {
       return false;
     }
   }
   bool service = await Geolocator.isLocationServiceEnabled();
   if(!service){
     return false;
   }
   return true;
  }

   Future<void>getSearchLocation(String address)async{
try{
  emit(LoadingMapState());
  bool stateLocation=await _checkStateLocation();
  if(stateLocation) {
    List<Location> location = await locationFromAddress(address);
    distanceBetweenLocations=Geolocator.distanceBetween(_latLng.latitude, _latLng.longitude, location[0].latitude, location[0].longitude);
    _latLng= LatLng(location[0].latitude, location[0].longitude);
    endLocation=_latLng;
    _destination=Marker(
      infoWindow: InfoWindow(title: "Destination" ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      markerId:MarkerId( _latLng.longitude.toString()),
      position:LatLng(location[0].latitude, location[0].longitude),
    );
    _markers.add(_destination!);
    List<Placemark> placeMark = await placemarkFromCoordinates(location[0].latitude, location[0].longitude);
    _placeMark=placeMark[0];

    emit(SuccessSearchLocationState());
    print("${distanceBetweenLocations}.******************************************");
    print(_latLng.latitude);
  }else{
    emit(ErrorStatusState());
  }
}catch(error){
  emit(ErrorMapState());
  print(error);
}
   }


}