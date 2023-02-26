import 'package:newproject/Model/spaceModel.dart';

class CategoryModel{
  String categoryId;
  String categoryImage;
  String categoryName;
  List<SpaceModel> categorySpaces;
  CategoryModel({
      required this.categoryId,
      required this.categoryImage,
      required this.categoryName,
      required this.categorySpaces

  });
  factory CategoryModel.fromJson(String key,Map data){
    return CategoryModel(
        categoryId: key,
        categoryImage: data["categoryImage"],
        categoryName: data["categoryName"],
        categorySpaces:[],
    );
  }

}