import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newproject/Controller/spaceController/spaceCubit.dart';
import 'package:newproject/Controller/spaceController/spaceStates.dart';
import 'package:newproject/Model/spaceModel.dart';
import 'package:newproject/View/shared_widget/favoriteIconButtonWidget.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';
import 'package:newproject/view/shared_widget/apartmentWidget.dart';
//import 'package:newproject/view/shared_widget/component.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';

import '../shared_widget/component.dart';

//import '../shared_widget/component.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen(this.spaceModel);
  SpaceModel spaceModel;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  /*List <String> photoGallery=[
    "https://cdn.vox-cdn.com/thumbor/1L4a4ve76ZqVZyjn0h5FWWxbcmQ=/0x0:4000x2667/920x613/filters:focal(1680x1014:2320x1654):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/65889507/0120_Westerly_Reveal_6C_Kitchen_Alt_Angles_Lights_on_15.14.jpg",
    "https://image.shutterstock.com/image-photo/modern-contemporary-en-suite-bahroom-600w-506610379.jpg",
    "https://media.istockphoto.com/photos/rendering-of-an-elegant-bedroom-picture-id1213695547",
    "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/white-bedrooms-1585283934.jpg?crop=1.00xw:0.755xh;0,0.0962xh&resize=980:*",
    "https://archello.s3.eu-central-1.amazonaws.com/images/2020/11/13/corpus-architects-luxury-modern-house-garden-design-residential-landscape-archello.1605283804.1979.jpg",

  ];*/
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpaceCubit, SpaceStates>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: SharedColors.BackGraundColor,
            appBar: AppBar(
              centerTitle: true,
              elevation: AppSize.size0,
              backgroundColor: SharedColors.BackGraundColor,
              title: Text(
                StringsManager.details,
                style: SharedFonts.primaryOrangeFont,
              ),
              leading: sharedIconButton(
                onPressed: () {
                  Navigator.pop(context);

                },
                icon:IconsManager.iconLift,
                  color: SharedColors.GreykColor,

              ),
              actions: [
                FavoriteIconButtonWidget(widget.spaceModel),
                sharedIconButton(
                  onPressed: () {},
                  icon:IconsManager.iconPhone,
                    color: SharedColors.GreykColor,
                ),
                sharedIconButton(
                  onPressed: () {},
                  icon:
                    IconsManager.iconMessege,
                    color: SharedColors.GreykColor,

                ),
              ],
            ),
            body: ListView(
              children: [
                Column(
                  children: [
                    ApartmentWidget(isDetail: true, spaceModel: widget.spaceModel),
                  ],
                ),
                titleSection(StringsManager.description),
                decoratedContainer(child:Text(
                  "\n   ${widget.spaceModel.spaceDescription}\n ",
                  style: SharedFonts.subGreyFont,
                )),
                titleSection(StringsManager.gallery),
                Container(
                  height: AppSize.size100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsetsDirectional.all(AppSize.size10),
                      height: AppSize.size90,
                      width: AppSize.size100,
                      decoration: BoxDecoration(
                          color: SharedColors.OrangeColor,
                          borderRadius:
                              BorderRadiusDirectional.circular(AppSize.size20),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                widget.spaceModel.spaceImgs[index]),
                          )),
                    ),
                    itemCount: widget.spaceModel.spaceImgs.length,
                  ),
                ),
                sharedButton(
                    title: StringsManager.rentNow,
                    onPressed:  () {})
              ],
            ),
            /*
            * floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton:
                sharedButton(title: StringsManager.rentNow, onPressed: () {})*/
        );
      },
    );
  }
}
