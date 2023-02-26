import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newproject/Controller/CategoryController/categoryCubit.dart';
import 'package:newproject/Controller/MapController/mapCubit.dart';
import 'package:newproject/Controller/spaceController/spaceCubit.dart';
import 'package:newproject/Controller/spaceController/spaceStates.dart';
import 'package:newproject/Model/categoryModel.dart';
import 'package:newproject/Model/spaceModel.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/imageManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';
import 'package:newproject/View/shared_theme/share_fonts.dart';
import 'package:newproject/View/shared_theme/shared_colors.dart';
import 'package:newproject/View/shared_widget/component.dart';
import 'package:newproject/View/shared_widget/inputFeildWidget.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class FloatingActionButtonWidget extends StatefulWidget {
  FloatingActionButtonWidget(this.scaffoldKey);
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<FloatingActionButtonWidget> createState() =>
      _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState
    extends State<FloatingActionButtonWidget> {
  List FABSectionList = [
    {
      "icon": IconsManager.iconCamera,
      "title": StringsManager.camera,
    },
    {
      "icon": IconsManager.iconPhoto,
      "title": StringsManager.gallery,
    }
  ];

  String valueType = "";
  String valueCategory = "";
  String valueRentType ="";

  List<File> imageData = [];
  File? imageDataCamera;
  File? imageDataGallery;

  bool FABisSelected = false;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController bedController = TextEditingController();
  TextEditingController bathroomController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  final descriptionKey = GlobalKey<ScaffoldState>();
  final addressKey = GlobalKey<ScaffoldState>();
  final priceKey = GlobalKey<ScaffoldState>();
  final nameKey = GlobalKey<ScaffoldState>();
  final bedKey = GlobalKey<ScaffoldState>();
  final bathroomKey = GlobalKey<ScaffoldState>();
  final aresKey = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();
  final popTypeKey = GlobalKey<PopupMenuButtonState>();
  final popCategoryKey = GlobalKey<PopupMenuButtonState>();
  final popRentypeKey = GlobalKey<PopupMenuButtonState>();

  @override
  Widget build(BuildContext context) {
    CategoryCubit categoryController=BlocProvider.of<CategoryCubit>(context);
    SpaceCubit spaceController = BlocProvider.of<SpaceCubit>(context);
   return BlocBuilder<SpaceCubit,SpaceStates>(
       builder:(context, state) {
         return FloatingActionButton(
           child: FABisSelected == false
               ? Icon(IconsManager.iconAdd)
               : sharedIconButton(
             color: SharedColors.GreykColor,
             icon:IconsManager.iconEdit,
             onPressed: () {
               Navigator.pop(context);
               setState(() {
                 FABisSelected = false;
               });
             },
           ),

           backgroundColor: FABisSelected == false
               ? SharedColors.OrangeColor
               : SharedColors.BalckColor,
           elevation: 5,
           onPressed: () {
             if (FABisSelected == false) {
               setState(() {
                 FABisSelected = !FABisSelected;
               });
               widget.scaffoldKey.currentState!.showBottomSheet((context) =>
                   Form(
                     key: formKey,
                     child: Container(
                       height: AppSize.size700,
                       child: ListView(
                         children: [
                           decoratedContainer(
                               child: imageDataList.isEmpty
                                   ? Image.asset(
                                 ImagesManager.noFoundImage,
                                 width: AppSize.size250,
                               )
                                   : ListView.builder(
                                 itemBuilder: (context, index) =>
                                     Image.file(
                                       File(imageDataList[index].path),
                                       width: AppSize.size300,
                                     ),
                                 itemCount: imageDataList.length,
                                 scrollDirection: Axis.horizontal,
                               )
                           ),

                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: [
                               InkWell(
                                 child: FABSection(FABSectionList[0]["icon"],
                                     FABSectionList[0]["title"]),
                                 onTap: () {
                                   //setState(() {});
                                   getCameraImages();
                                 },
                               ),
                               InkWell(
                                 child: FABSection(FABSectionList[1]["icon"],
                                     FABSectionList[1]["title"]),
                                 onTap: () {
                                   //setState(() {});
                                   getMultiImages();
                                 },
                               ),
                             ],
                           ),
                           titleSection(StringsManager.name),
                           InputField(
                             model: InputModel(
                               controller: nameController,
                               key: nameKey,
                               prefix: IconsManager.iconHouse,
                               keyboardType: TextInputType.text,
                               validateTitle: StringsManager.pleaseEnterYour +
                                   " " +
                                   StringsManager.name,
                             ),
                           ),
                           titleSection(StringsManager.description),
                           InputField(
                             model: InputModel(
                               controller: descriptionController,
                               key: descriptionKey,
                               prefix: IconsManager.iconText,
                               keyboardType: TextInputType.text,
                               validateTitle: StringsManager.pleaseEnterYour +
                                   " " +
                                   StringsManager.description,
                             ),
                           ),
                           titleSection(StringsManager.address),
                           InputField(
                             model: InputModel(
                               controller: addressController,
                               key: addressKey,
                               prefix: IconsManager.iconLocation,
                               keyboardType: TextInputType.text,
                               validateTitle: StringsManager.pleaseEnterYour +
                                   " " +
                                   StringsManager.address,
                             ),
                           ),
                           Row(
                             children: [
                               Column(
                                 children: [
                                   titleSection(StringsManager.area),
                                   InputField(
                                     model: InputModel(
                                       width: AppSize.size80,
                                       controller: areaController,
                                       key: aresKey,
                                       prefix: IconsManager.iconLandscape,
                                       keyboardType: TextInputType.number,
                                       validateTitle:
                                       StringsManager.pleaseEnterYour +
                                           " " +
                                           StringsManager.area,
                                     ),
                                   ),
                                 ],
                               ),
                               Column(
                                 children: [
                                   titleSection(StringsManager.bed),
                                   InputField(
                                     model: InputModel(
                                       width: AppSize.size100,
                                       controller: bedController,
                                       key: bedKey,
                                       prefix: IconsManager.iconBed,
                                       keyboardType: TextInputType.number,
                                       validateTitle:
                                       StringsManager.pleaseEnterYour +
                                           " " +
                                           StringsManager.bed,
                                     ),
                                   ),
                                 ],
                               ),
                               Column(
                                 children: [
                                   titleSection(StringsManager.bathroom),
                                   InputField(
                                     model: InputModel(
                                       width: AppSize.size100,
                                       controller: bathroomController,
                                       key: bathroomKey,
                                       prefix: IconsManager.iconBathroom,
                                       keyboardType: TextInputType.number,
                                       validateTitle:
                                       StringsManager.pleaseEnterYour +
                                           " " +
                                           StringsManager.bathroom,
                                     ),
                                   ),
                                 ],
                               )
                             ],
                           ),
                           titleSection(StringsManager.price),
                           InputField(
                             model: InputModel(
                               controller: priceController,
                               key: priceKey,
                               prefix: IconsManager.iconMoney,
                               keyboardType: TextInputType.text,
                               validateTitle: StringsManager.pleaseEnterYour +
                                   " " +
                                   StringsManager.price,
                             ),
                           ),
                           ListTile(
                             leading: titleSection(StringsManager.type),
                             title: Text(
                               valueType,
                               style: SharedFonts.subOrangeFont,
                             ),
                             subtitle:Text(valueType) ,
                             trailing: PopupMenuButton(
                               itemBuilder: (BuildContext context) {
                                 return <PopupMenuEntry<String>>[
                                   PopupMenuItem(
                                     child: Text(StringsManager.rent),
                                     value: StringsManager.rent,
                                   ),
                                   PopupMenuItem(
                                     child: Text(StringsManager.sell),
                                     value: StringsManager.sell,
                                   )
                                 ];
                               },
                               key: popTypeKey,
                               onSelected: (value) {
                                 valueType=value.toString();
                                 spaceController.changePopUp(valueType , value.toString());
                                 //setState(() {});
                               },
                             ),
                           ),
                           ListTile(
                             leading: titleSection(StringsManager.category),
                             title: Text(
                               valueCategory,
                               style: SharedFonts.subOrangeFont,
                             ),
                             subtitle:Text(valueCategory) ,
                             trailing: PopupMenuButton(
                               key: popCategoryKey,
                               elevation: 10,
                               itemBuilder: (BuildContext context) {
                                 return <PopupMenuEntry<String>>[
                                   for (CategoryModel categoryModel in categoryController
                                       .categorise )
                                     PopupMenuItem(
                                       value: categoryModel.categoryId,
                                       child: Text(categoryModel.categoryName),
                                     ),
                                 ];
                               },
                               onSelected: (value) {
                                 valueCategory=value.toString();
                                 spaceController.changePopUp(valueCategory , value.toString());


                               },
                             ),
                           ),
                           ListTile(
                             leading: titleSection(StringsManager.rentType),
                             title: Text(
                               valueRentType,
                               style: SharedFonts.subOrangeFont,
                             ),
                             subtitle:Text(valueRentType) ,
                             trailing: PopupMenuButton(
                               itemBuilder: (BuildContext context) {
                                 return <PopupMenuEntry<String>>[
                                   PopupMenuItem(
                                     child: Text(StringsManager.week),
                                     value: StringsManager.week,

                                   ),
                                   PopupMenuItem(
                                     child: Text(StringsManager.month),
                                     value: StringsManager.month,
                                   ),
                                   PopupMenuItem(
                                     child: Text(StringsManager.year),
                                     value: StringsManager.year,
                                   ),
                                 ];
                               },
                               onSelected: (value) {
                                 valueRentType=value.toString();
                                 spaceController.changePopUp(valueRentType , value.toString());
                                 //setState(() {});
                               },
                               key: popRentypeKey,
                             ),
                           ),
                           Builder(
                             builder: (context) =>
                                 sharedButton(
                                     title: StringsManager.submit,
                                     onPressed: () async {
                                       if (formKey.currentState!.validate()) {
                                         MapController mapController = BlocProvider
                                             .of<MapController>(context);
                                         await mapController.getUserLocation();
                                         SpaceModel newSpace = SpaceModel(
                                             userId:"1" ,
                                             spaceId: "",
                                             categoryId: valueCategory,
                                             spaceName: nameController.text,
                                             addType: valueType,
                                             recommended: true,
                                             rentType: valueRentType,
                                             spaceArea: num.parse(
                                                 areaController.text),
                                             spaceBathRoom: num.parse(
                                                 bathroomController.text),
                                             spaceBeds: num.parse(
                                                 bedController.text),
                                             spaceDescription: "Apartement For Sale nearby great locations and famous restaurant with perfect views Apartement For Sale nearby great locations and famous restaurant with perfect views Apartement For Sale nearby great locations and famous restaurant with perfect views",
                                             spaceImgs: photoGallery,
                                             spaceLat: mapController.latlng
                                                 .latitude,
                                             spaceLng: mapController.latlng
                                                 .longitude,
                                             spaceLocation: "Cairo,Nasir City",
                                             spacePrice: num.parse(
                                                 priceController.text),
                                             favorite: false,
                                             inFavoritList: "");
                                         spaceController.addSpace(newSpace);
                                         if (state is SuccessAddSpaceState) {
                                           ScaffoldMessenger.of(context)
                                               .showSnackBar(
                                               snack(title: StringsManager
                                                   .addedSuccessfully,
                                                   color: SharedColors
                                                       .greenColor)
                                           );
                                         } else {
                                           ScaffoldMessenger.of(context)
                                               .showSnackBar(
                                               snack(title: StringsManager
                                                   .addedCorrectly,
                                                   color: SharedColors
                                                       .errorColor)
                                           );
                                         }

                                         setState(() {
                                           FABisSelected = false;
                                         });
                                        Navigator.pushNamed(context, "userShow");
                                       }
                                     }),
                           ),

                         ],
                       ),
                     ),
                   ));
             }
           },

         );
       }
         );
  }

  getImages() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      imageData.add(imageDataCamera = File(image!.path));
    });
  }

  List<XFile> imageDataList = [];

  void getMultiImages() async {
    final List<XFile> images = await ImagePicker().pickMultiImage();
    setState(() {
      if (images.isNotEmpty) {
        imageDataList.addAll(images);
        print(imageDataList.length.toString());
      }
    });
  }

  void getCameraImages() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        imageDataList.add(image);
        print(imageDataList.length.toString());
      }
    });
  }
}









/*
*
* */




/* Builder(
                        builder: (context) => TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: SharedColors.WhiteColor,
                                content: Text(
                                  StringsManager.addedSuccessfully,
                                  style: SharedFonts.primaryOrangeFont,
                                ),
                                duration:
                                    Duration(milliseconds: AppSize.size500),
                              ));
                              setState(() {
                                FABisSelected = false;
                              });
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserApartmentScreen()));
                            }
                          },
                          child: Container(
                            width: AppSize.size130,
                            height: AppSize.size40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: SharedColors.OrangeColor,
                              borderRadius: BorderRadiusDirectional.circular(
                                  AppSize.size5),
                            ),
                            child: Text(
                              StringsManager.submit,
                              style: SharedFonts.primaryGreyFont,
                            ),
                          ),
                        ),
                      ),*/