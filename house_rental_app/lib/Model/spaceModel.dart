
class SpaceModel{
  String spaceId;
  String categoryId;
  String spaceName;
  String addType;
  bool recommended;
  String rentType;
  num spaceArea;
  num spaceBathRoom;
  num spaceBeds;
  String spaceDescription;
  List spaceImgs;
  num spaceLat;
  num spaceLng;
  String spaceLocation;
  num spacePrice;
  bool favorite;
  String inFavoritList;
  String userId;
  SpaceModel({
    required this.userId,
    required this.spaceId,
    required this.categoryId,
    required this.spaceName,
    required this.addType,
    required this.recommended,
    required this.rentType,
    required this.spaceArea,
    required this.spaceBathRoom,
    required this.spaceBeds,
    required this.spaceDescription,
    required this.spaceImgs,
    required this.spaceLat,
    required this.spaceLng,
    required this.spaceLocation,
    required this.spacePrice,
    required this.favorite,
    required this.inFavoritList
});

 factory SpaceModel.fromJson(String key, Map data){
  return SpaceModel(
      userId:data["userId"],
      spaceId: key,
      categoryId: data["categoryId"],
      spaceName: data["spaceName"],
      addType: data["addType"],
      recommended: data["recommended"],
      rentType: data["rentType"] ,
      spaceArea: data["spaceArea"],
      spaceBathRoom: data["spaceBathRoom"],
      spaceBeds: data["spaceBeds"],
      spaceDescription:data["spaceDescription"] ,
      spaceImgs: data["spaceImgs"],
      spaceLat: data["spaceLat"],
      spaceLng: data["spaceLng"],
      spaceLocation: data["spaceLocation"],
      spacePrice: data["spacePrice"],
      favorite: false,
      inFavoritList: ""
  );
  }

  @override
  String toString() {
    // TODO: implement toString
    return " ${this.spaceId},${this.categoryId},${this.spaceName},${this.addType},${this.recommended},${this.rentType},${this.spaceArea},${this.spaceBathRoom},${this.spaceBeds},${this.spaceDescription},${this.spaceImgs},${this.spaceLat},${this.spaceLng},${this.spaceLocation},${this.spacePrice},${this.favorite}";

  }

}