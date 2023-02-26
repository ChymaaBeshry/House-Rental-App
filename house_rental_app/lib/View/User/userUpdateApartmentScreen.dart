import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newproject/Controller/CategoryController/categoryCubit.dart';
import 'package:newproject/Controller/spaceController/spaceCubit.dart';
import 'package:newproject/Controller/spaceController/spaceStates.dart';
import 'package:newproject/Model/spaceModel.dart';
import 'package:newproject/Model/updateSpaceModel.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';
import 'package:newproject/View/shared_theme/share_fonts.dart';
import 'package:newproject/View/shared_theme/shared_colors.dart';
import 'package:newproject/View/shared_widget/component.dart';
import 'package:newproject/View/shared_widget/inputFeildWidget.dart';
import 'dart:io';

class UserUpdateApartmentScreen extends StatefulWidget {

  UserUpdateApartmentScreen({required this.spaceModel});
  SpaceModel spaceModel;
  @override
  State<UserUpdateApartmentScreen> createState() =>
      _UserUpdateApartmentScreenState();
}

class _UserUpdateApartmentScreenState extends State<UserUpdateApartmentScreen> {
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

  List<File> imageData = [];
  File? imageDataCamera;
  File? imageDataGallery;

  bool FABisSelected = false;

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
  void initState() {
    BlocProvider.of<SpaceCubit>(context).getSpaceDate(widget.spaceModel);
  }

  @override
  Widget build(BuildContext context) {
    UpdateSpaceModel spaceDate =
        BlocProvider.of<SpaceCubit>(context).userSpaceDate;
    CategoryCubit categoryDate = BlocProvider.of<CategoryCubit>(context);
    SpaceCubit spaceCubit = BlocProvider.of<SpaceCubit>(context);
    return BlocBuilder<SpaceCubit,SpaceStates>(
      builder: (context,state){
        return   Scaffold(
          body: Form(
            key: formKey,
            child: Container(
              height: AppSize.size700,
              child: ListView(
                children: [
                  Container(
                    height: AppSize.size200,
                    child: decoratedContainer(child: ListView.builder(
                      itemBuilder: (context, index) =>
                          Padding(
                            padding: const EdgeInsets.all(AppSize.size5),
                            child: Image.network(widget.spaceModel.spaceImgs[index]),
                          ),
                      itemCount: widget.spaceModel.spaceImgs.length,
                      scrollDirection: Axis.horizontal,
                    )),
                  ),
                  titleSection(StringsManager.name),
                  InputField(
                    model: InputModel(
                      controller: spaceDate.nameController,
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
                      controller: spaceDate.descriptionController,
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
                      controller: spaceDate.addressController,
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
                              controller: spaceDate.areaController,
                              key: aresKey,
                              prefix: IconsManager.iconLandscape,
                              keyboardType: TextInputType.number,
                              validateTitle: StringsManager.pleaseEnterYour +
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
                              controller: spaceDate.bedController,
                              key: bedKey,
                              prefix: IconsManager.iconBed,
                              keyboardType: TextInputType.number,
                              validateTitle: StringsManager.pleaseEnterYour +
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
                              controller: spaceDate.bathroomController,
                              key: bathroomKey,
                              prefix: IconsManager.iconBathroom,
                              keyboardType: TextInputType.number,
                              validateTitle: StringsManager.pleaseEnterYour +
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
                      controller: spaceDate.priceController,
                      key: priceKey,
                      prefix: IconsManager.iconMoney,
                      keyboardType: TextInputType.text,
                      validateTitle: StringsManager.pleaseEnterYour +
                          " " +
                          StringsManager.price,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      StringsManager.type,
                      style: SharedFonts.subOrangeFont,
                    ),
                    subtitle: Text(spaceDate.valueType),
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
                      // initialValue: valueType,
                      onSelected: (value) {
                        spaceDate.valueType = value.toString();
                        spaceCubit.changePopUp(spaceDate.valueType, value.toString());
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      StringsManager.category,
                      style: SharedFonts.subOrangeFont,
                    ),
                    subtitle: Text(spaceDate.valueCategory),
                    trailing: PopupMenuButton(
                      key: popCategoryKey,
                      elevation: 10,
                      // initialValue:valueCategory ,
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          for (int i = 0; i < categoryDate.categorise.length; i++)
                            PopupMenuItem(
                              value: categoryDate.categorise[i].categoryId,
                              child: Text(categoryDate.categorise[i].categoryName),
                              //value: Categorytitle[0] ,
                            ),
                        ];
                      },
                      onSelected: (value) {
                        spaceDate.valueCategory = value.toString();
                        spaceCubit.changePopUp(spaceDate.valueCategory, value.toString());
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      StringsManager.rentType,
                      style: SharedFonts.subOrangeFont,
                    ),
                    subtitle: Text(
                      spaceDate.valueRentType,
                    ),
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
                        spaceDate.valueRentType = value.toString();
                        spaceCubit.changePopUp(spaceDate.valueRentType, value.toString());
                      },
                      key: popRentypeKey,
                      //initialValue: valueRentType,
                    ),
                  ),
                  Builder(
                      builder: (context) => sharedButton(
                          title: StringsManager.update,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              SpaceModel newUpdateSpace =SpaceModel(
                                  userId: widget.spaceModel.userId,
                                  spaceId: widget.spaceModel.spaceId,
                                  categoryId: spaceDate.valueCategory,
                                  spaceName: spaceDate.nameController.text,
                                  addType: spaceDate.valueType,
                                  recommended: true,
                                  rentType: spaceDate.valueRentType,
                                  spaceArea:num.parse( spaceDate.areaController.text),
                                  spaceBathRoom: num.parse( spaceDate.bathroomController.text),
                                  spaceBeds: num.parse( spaceDate.bedController.text),
                                  spaceDescription: spaceDate.descriptionController.text,
                                  spaceImgs: widget.spaceModel.spaceImgs,
                                  spaceLat: widget.spaceModel.spaceLat,
                                  spaceLng: widget.spaceModel.spaceLng,
                                  spaceLocation: spaceDate.addressController.text,
                                  spacePrice: num.parse( spaceDate.priceController.text),
                                  favorite: false,
                                  inFavoritList: "");
                              BlocProvider.of<SpaceCubit>(context).updateSpace(newUpdateSpace);
                              ScaffoldMessenger.of(context).showSnackBar(
                                snack(
                                    title: StringsManager.apartmentUpdated,
                                    color: SharedColors.greenColor),
                              );
                              Navigator.pushNamed(context,"userShow");
                              } else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                snack(
                                    title: StringsManager.apartmentNotUpdated,
                                    color: SharedColors.errorColor),
                              );
                            }

                          })),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
/* TextButton(
                     onPressed: () {
                       if (formKey.currentState!.validate()) {
                         ScaffoldMessenger.of(context).showSnackBar(
                             snack(
                                 title: StringsManager.addedSuccessfully,
                                 color: SharedColors.greenColor),
                         );
                         setState(() {
                           FABisSelected = false;
                         });
                          Navigator.pushReplacement(context,
                             MaterialPageRoute(builder: (context) =>
                                 UserApartmentScreen()));
                       }
                     },
                     child: Container(
                       width: AppSize.size130,
                       height: AppSize.size40,
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                         color: SharedColors.OrangeColor,
                         borderRadius: BorderRadiusDirectional
                             .circular(AppSize.size5),
                       ),
                       child: Text(StringsManager.submit,style: SharedFonts.primaryGreyFont,),

                     ),
                   ),*/
