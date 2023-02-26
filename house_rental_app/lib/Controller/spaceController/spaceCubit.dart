import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:newproject/Controller/CategoryController/categoryCubit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:newproject/Controller/spaceController/spaceStates.dart';
import 'package:newproject/Model/categoryModel.dart';
import 'package:newproject/Model/spaceModel.dart';
import 'package:newproject/Model/updateSpaceModel.dart';

class SpaceCubit extends Cubit<SpaceStates> {
  SpaceCubit() : super(InitialSpaceState()) {
    getSpaces();
    getFavoriteList();

  }

  List<SpaceModel> _spaces = [];
  List<SpaceModel> get spaces => _spaces;

  List<SpaceModel> _userSpaces = [];
  List<SpaceModel> get userSpaces => _userSpaces;

  UpdateSpaceModel? _userSpaceDate ;
  UpdateSpaceModel get userSpaceDate => _userSpaceDate!;

  List<SpaceModel> _favoriteList = [];
  List<SpaceModel> get favoriteList => _favoriteList;
  List<SpaceModel> _nearbyList = [];
  List<SpaceModel> get nearbyList => _nearbyList;

  List<SpaceModel> _recommendedSpaceList=[];
  List<SpaceModel> get recommendedSpaceList=>_recommendedSpaceList;

  void getRecommendedSpaces(){
    _spaces.forEach((element) {
      if(element.recommended==true){
        _recommendedSpaceList.add(element);
      }
    });
    emit(RecommendSpacesState());
  }

  void categorySpaces(CategoryModel category) {
    try {
       category.categorySpaces.clear();
      for (SpaceModel space in _spaces) {
        if (space.categoryId == category.categoryId) {
          category.categorySpaces.add(space);
        }
      };
       emit(CategorySpacesState());
    } catch (e) {
      print(e);
    }
  }

  Future<void> getSpaces() async {
    emit(LoadingSpaceState());
    try {
      http.Response res = await http.get(Uri.parse("$domain/space.json"));
      if (res.statusCode == 200) {
        _spaces.clear();
        Map data = json.decode(res.body);
        data.forEach((key, value) {
          SpaceModel space=SpaceModel.fromJson(key, value);
          if(space.userId == "1"){
            _userSpaces.add(space);
          }
          _spaces.add(space);

        });
        emit(SuccessSpaceState());
      } else {
        emit(ErrorSpaceState());
      }
    } catch (error) {
      emit(ErrorSpaceState());
      print(error);
    }
  }

  Future<void> addSpace(SpaceModel space) async {
    //بعت دول بس علشان دول اللي بضيفهم في الداتا بيز لكن الباثي بضيفه هنا
    Map sendData={
      "userId":space.userId,
      "categoryId": space.categoryId,
      "spaceName": space.spaceName,
      "addType": space.addType,
      "recommended": space.recommended,
      "rentType": space.rentType ,
      "spaceArea": space.spaceArea,
      "spaceBathRoom": space.spaceBathRoom,
      "spaceBeds": space.spaceBeds,
      "spaceDescription":space.spaceDescription ,
      "spaceImgs": space.spaceImgs,
      "spaceLat": space.spaceLat,
      "spaceLng": space.spaceLng,
      "spaceLocation": space.spaceLocation,
      "spacePrice": space.spacePrice,
    };
    try {
      http.Response res = await http.post(Uri.parse("$domain/space.json"),
          body: json.encode(sendData));
      if (res.statusCode == 200) {
        Map data=json.decode(res.body);
        space.spaceId=data["name"];
        _spaces.add(space);
        _userSpaces.add(space);
        emit(SuccessAddSpaceState());
      } else {
        emit(ErrorAddSpaceState());
      }
    } catch (error) {
      emit(ErrorAddSpaceState());
      print(error);
    }
  }

  Future<void> getFavoriteList() async {
    try {
      emit(LoadingGetFavoriteState());
      http.Response res =
          await http.get(Uri.parse("$domain/favoriteList.json"));
      if (res.statusCode == 200) {
        Map data = json.decode(res.body);
        data.forEach((key, value) {
          for (SpaceModel space in _spaces) {
            if (value["spaceId"]==space.spaceId ) {
              space.favorite = true;
              space.inFavoritList=key;
              _favoriteList.add(space);
              print(_favoriteList);
            }
          }
        });
        emit(SuccessGetFavoriteState());
      } else {
        emit(ErrorGetFavoriteState());
      }
    } catch (error) {
      emit(ErrorGetFavoriteState());
      print(error);
    }
  }

  Future<void> handleFavorite(SpaceModel space) async {
    bool isSuccess=false;
    if (space.favorite) {
      isSuccess= await deleteFavorite(space);
    } else {
      isSuccess=  await addFavorite(space);
    }
    emit( isSuccess==true? FavoriteSuccessState():FavoriteErrorState());
    //return isSuccess;
  }

  Future<bool> addFavorite(SpaceModel space) async {
    Map sendData = {"spaceId": space.spaceId, "userId": 1};
    try {
      http.Response res = await http.post(
        Uri.parse("$domain/favoriteList.json"),
        body: json.encode(sendData),
      );
      if (res.statusCode == 200) {
        space.favorite = true;
        favoriteList.add(space);
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  Future<bool> deleteFavorite(SpaceModel space) async {
    try {
      http.Response res = await http
          .delete(Uri.parse("$domain/favoriteList/${space.inFavoritList}.json"));
      if (res.statusCode == 200) {
        space.favorite = false;
        for (int i = 0; i < _favoriteList.length; i++) {
          if ( _favoriteList[i].spaceId==space.spaceId) {
            _favoriteList.removeAt(i);
            break;
          }
        }
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  Future deleteSpace(SpaceModel space)async{
  try{
    http.Response res= await http.delete(Uri.parse("$domain/spaces/${space.spaceId}.json"));
    if(res.statusCode ==200){
      List<List<SpaceModel>> spaces=[_spaces ,_userSpaces ,_nearbyList ,_recommendedSpaceList,_favoriteList];
      for(List<SpaceModel> spaceList in spaces){
        for(int i=0 ; i<spaceList.length; i++) {
          if ( space.spaceId == spaceList[i].spaceId) {
            spaceList.removeAt(i);
            break;
          }
        }
      }

   /*   for(int i=0 ; i<_spaces.length; i++) {
        if ( space.spaceId == _spaces[i].spaceId) {
          _spaces.removeAt(i);
          break;
        }
      }
      for(int i=0 ; i<_nearbyList.length; i++) {
        if ( space.spaceId == _nearbyList[i].spaceId) {
          _nearbyList.removeAt(i);
          break;
        }
      }
      for(int i=0 ; i<_recommendedSpaceList.length; i++) {
        if ( space.spaceId == _recommendedSpaceList[i].spaceId) {
          _recommendedSpaceList.removeAt(i);
          break;
        }
      }
      for(int i=0 ; i<_userSpaces.length; i++) {
        if ( space.spaceId== _userSpaces[i].spaceId) {
          _userSpaces.removeAt(i);
          break;
        }
      }*/
      emit(SuccessDeleteSpaceState());
    }else{
      emit(ErrorDeleteSpaceState());
    }
  }catch(error){
    emit(ErrorDeleteSpaceState());
    print(error);
  }
  }

  void getSpaceDate(SpaceModel space){
     _userSpaceDate = UpdateSpaceModel.space(space);
    emit(GetDataSpacesState());
  }

  Future<void> updateSpace(SpaceModel space)async{
    try{
      emit(LoadingUpdateSpaceState());
      Map data={
        "userId":space.userId,
        "categoryId": space.categoryId,
        "spaceName": space.spaceName,
        "addType": space.addType,
        "recommended": space.recommended,
        "rentType": space.rentType ,
        "spaceArea": space.spaceArea,
        "spaceBathRoom": space.spaceBathRoom,
        "spaceBeds": space.spaceBeds,
        "spaceDescription":space.spaceDescription,
        "spaceImgs": space.spaceImgs,
        "spaceLat": space.spaceLat,
        "spaceLng": space.spaceLng,
        "spaceLocation": space.spaceLocation,
        "spacePrice": space.spacePrice,
      };
      http.Response res= await http.put(Uri.parse("$domain/space/${space.spaceId}.json"),
          body:json.encode(data) );
      if(res.statusCode ==200){
        List<List<SpaceModel>> spaces=[_spaces ,_userSpaces ,_nearbyList ,_recommendedSpaceList,_favoriteList];
        for(List<SpaceModel> spaceList in spaces){
          for(int i=0; i<spaceList.length; i++){
            if(space.spaceId == spaceList[i].spaceId){
              spaceList[i] = space;
              break;
            }
          }
          }
        emit(SuccessUpdateSpaceState());
      }else{
        emit(ErrorUpdateSpaceState());

      }
    }catch(error){
      emit(ErrorUpdateSpaceState());
      print(error);
    }
}

  void getNearbySpace(LatLng current){
    _nearbyList.clear();
    for(SpaceModel space in _spaces){
      double dis = Geolocator.distanceBetween(current.latitude, current.longitude,space.spaceLat.toDouble(), space.spaceLng.toDouble());
      print(dis);
      if(dis <= 60520){
        _nearbyList.add(space);
        print(_nearbyList.length);
      }
    }

  }


  void changePopUp(String value , String change){
    value = change;
    emit(ChangePopUpState());

  }

/*
* Future<void> updateSpace(SpaceModel space)async{
    Map data={
      "userId":space.userId,
      "categoryId": space.categoryId,
      "spaceName": space.spaceName,
      "addType": space.addType,
      "recommended": space.recommended,
      "rentType": space.rentType ,
      "spaceArea": space.spaceArea,
      "spaceBathRoom": space.spaceBathRoom,
      "spaceBeds": space.spaceBeds,
      "spaceDescription":space.spaceDescription,
      "spaceImgs": space.spaceImgs,
      "spaceLat": space.spaceLat,
      "spaceLng": space.spaceLng,
      "spaceLocation": space.spaceLocation,
      "spacePrice": space.spacePrice,
    };
    http.Response res= await http.put(Uri.parse("$domain/spaces/${space.spaceId}.json"),
    body:json.encode(data) );
    if(res.statusCode ==200){
      for(int i=0; i<_spaces.length; i++){
        if(space.spaceId == _spaces[i].spaceId){
          space=_spaces[i];
          //break;
        }
      }
    }
}
*/






}
