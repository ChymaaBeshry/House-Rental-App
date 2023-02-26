
import 'package:flutter/widgets.dart';
import 'package:newproject/Model/spaceModel.dart';

class UpdateSpaceModel{
  TextEditingController descriptionController;
  TextEditingController addressController;
  TextEditingController priceController;
  TextEditingController nameController;
  TextEditingController bedController;
  TextEditingController bathroomController;
  TextEditingController areaController;
  String valueType;
  String valueCategory;
  String valueRentType ;


  UpdateSpaceModel({
    required this.descriptionController,
    required this.nameController,
    required this.bedController,
    required this.priceController,
    required this.bathroomController,
    required this.areaController,
    required this.addressController,
    required this.valueRentType,
    required this.valueType,
    required this.valueCategory,
  });

  factory UpdateSpaceModel.space(SpaceModel space){
    return UpdateSpaceModel(
      addressController: TextEditingController(text: space.spaceLocation),
      areaController: TextEditingController(text: space.spaceArea.toString()),
      bathroomController: TextEditingController(text: space.spaceBathRoom.toString()),
      bedController: TextEditingController(text: space.spaceBeds.toString()),
      descriptionController: TextEditingController(text: space.spaceDescription),
      nameController:TextEditingController(text: space.spaceName),
      priceController: TextEditingController(text: space.spacePrice.toString()),
      valueCategory:space.categoryId,
      valueRentType: space.rentType,
      valueType: space.addType,
    );
  }


}

