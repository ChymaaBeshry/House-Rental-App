import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newproject/Controller/spaceController/spaceCubit.dart';
import 'package:newproject/Controller/spaceController/spaceStates.dart';
import 'package:newproject/Model/spaceModel.dart';
import 'package:newproject/View/shared_widget/favoriteIconButtonWidget.dart';
import 'package:newproject/View/shared_widget/sectionEditDeleteUserApartment.dart';
import 'package:newproject/View/space/detailsScreen.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';
import 'package:newproject/View/shared_theme/share_fonts.dart';
import 'package:newproject/View/shared_theme/shared_colors.dart';
import 'package:newproject/View/shared_widget/component.dart';

class ApartmentWidgetVertical extends StatefulWidget {
  bool isDetail;
  SpaceModel spaceModel;
  ApartmentWidgetVertical({
    required this.isDetail,
    required this.spaceModel,

  });

  @override
  State<ApartmentWidgetVertical> createState() => _ApartmentWidgetVerticalState();
}

class _ApartmentWidgetVerticalState extends State<ApartmentWidgetVertical> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.fromSTEB(AppSize.size10, AppSize.size10, AppSize.size10, AppSize.size10),
      //padding: EdgeInsetsDirectional.all(AppSize.size5),
      height: AppSize.size170,
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(AppSize.size20),
          color: SharedColors.WhiteColor
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: widget.isDetail == false ? () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return DetailsScreen(widget.spaceModel);
                  },));
            } : () {},
            child: Container(
              width: AppSize.size100,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(AppSize.size20),
                image: DecorationImage(
                  image: NetworkImage(widget.spaceModel.spaceImgs[0]),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("\n${widget.spaceModel.spaceName}",
                  style: SharedFonts.primaryBlackFont,
                  maxLines: 2,),
                apartmentDetail(widget.spaceModel.spaceLocation,IconsManager.iconLocation),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        apartmentDetail("${widget.spaceModel.spaceBeds} bed", IconsManager.iconBed),
                        apartmentDetail("${widget.spaceModel.spaceBathRoom} bath", IconsManager.iconBathroom),
                        apartmentDetail("${widget.spaceModel.spaceArea} k/m", IconsManager.iconLandscape),
                      ],
                    ),
                    Column(
                      children: [
                        Text("\n${widget.spaceModel.spacePrice} EGP",
                          style: SharedFonts.primaryOrangeFont,),
                        Text("${widget.spaceModel.rentType}", style: SharedFonts.primaryOrangeFont),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        for(int i = 0; i < 4; i++)
                          Icon(IconsManager.iconStar,
                            color: SharedColors.yellowColor,
                            size: AppSize.size15,),
                        Icon(IconsManager.iconStar,
                          color: SharedColors.yellowColor,
                          size: AppSize.size15,),
                      ],
                    ),
                    /* IconButton(onPressed: () {
                                    state.spaces[index].favorite =
                                    !state.spaces[index].favorite;
                                    BlocProvider.of<SpaceCubit>(context)
                                        .handleFavorite(state.spaces[index]);
                                  }, icon: Icon(IconsManager.iconFavorite,
                                    color: state.spaces[index].favorite == true
                                        ? SharedColors.OrangeColor
                                        : SharedColors.BalckColor,)),*/
                    widget.spaceModel.userId=="1"? SectionEditDeleteUserApartment(widget.spaceModel):
                    widget.isDetail == false?FavoriteIconButtonWidget(widget.spaceModel):SizedBox(),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*
BlocBuilder<SpaceCubit, SpaceStates>(
        builder: (context, state) {
          if (state is LoadingSpaceState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SuccessSpaceState) {
            return

          } else {
            return Center(child: Text(
              "some thing went wrong", style: SharedFonts.primaryOrangeFont,),);
          }
        }
    );

* Container(
              height: AppSize.size170,
              child: ListView.builder(
                 // scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) =>
                      Container(
                          margin: EdgeInsetsDirectional.fromSTEB(AppSize.size10, AppSize.size10, AppSize.size10, AppSize.size10),
                        //padding: EdgeInsetsDirectional.all(AppSize.size5),
                          height: AppSize.size170,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(AppSize.size20),
                              color: SharedColors.WhiteColor
                          ),
                          child: Row(
                           // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: isDetail == false ? () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                        return DetailsScreen();
                                      },));
                                } : () {},
                                child: Container(
                                  width: AppSize.size100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.circular(AppSize.size20),
                                    image: DecorationImage(
                                      image: NetworkImage(state.spaces[index].spaceImgs[0]),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("\n${state.spaces[index].spaceName}",
                                      style: SharedFonts.primaryBlackFont,
                                      maxLines: 2,),
                                    apartmentDetail(state.spaces[index].spaceLocation,IconsManager.iconLocation),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            apartmentDetail("${state.spaces[index].spaceBeds} bed", IconsManager.iconBed),
                                            apartmentDetail("${state.spaces[index].spaceBathRoom} bath", IconsManager.iconBathroom),
                                            apartmentDetail("${state.spaces[index].spaceArea}100 k/m", IconsManager.iconLandscape),
                                          ],
                                        ),
                                         Column(
                                         children: [
                                           Text("\n${state.spaces[index].spacePrice} EGP",
                                             style: SharedFonts.primaryOrangeFont,),
                                           Text("${state.spaces[index].rentType}", style: SharedFonts.primaryOrangeFont),
                                         ],
                                       )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            for(int i = 0; i < 4; i++)
                                              Icon(IconsManager.iconStar,
                                                color: SharedColors.yellowColor,
                                                size: AppSize.size15,),
                                            Icon(IconsManager.iconStar,
                                              color: SharedColors.yellowColor,
                                              size: AppSize.size15,),
                                          ],
                                        ),
                                        IconButton(onPressed: () {
                                          state.spaces[index].favorite =
                                          !state.spaces[index].favorite;
                                          BlocProvider.of<SpaceCubit>(context)
                                              .handleFavorite(state.spaces[index]);
                                        }, icon: Icon(IconsManager.iconFavorite,
                                          color: state.spaces[index].favorite == true
                                              ? SharedColors.OrangeColor
                                              : SharedColors.BalckColor,)),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                  itemCount: state.spaces.length,
              ),
            );*/
/*
* InkWell(
      onTap: () {
           Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) {
         return DetailsScreen();
      },));
     },
      child: Container(
          margin: EdgeInsetsDirectional.fromSTEB(AppSize.size10, AppSize.size10, AppSize.size10, AppSize.size10),
         padding: EdgeInsetsDirectional.all(AppSize.size5),
          height: AppSize.size120,
          decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(AppSize.size20),
          color: SharedColors.WhiteColor
        ),

           child: Row(
               children: [
                 Container(
                    height: AppSize.size80,
                   width: AppSize.size80,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(AppSize.size20),
                    image: DecorationImage(
                    image: NetworkImage(apartmentphoto[index],),
                    fit: BoxFit.fill,
),
),
),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Text("\n Premium",
                                 style: SharedFonts.primaryBlackFont,
                            maxLines: 2,),
                              Text("\n8500 EGP",
                                style: SharedFonts.primaryOrangeFont,)
],
),

                                apartmentDetail("Dokki",IconsManager.iconLocation),

                                  Row(
                          children: [
                                    apartmentDetail(" 4 bed  ",  IconsManager.iconBed),
                                    apartmentDetail(" 3 bath  ",  IconsManager.iconBathroom),
                                    apartmentDetail("2600 km  ",  IconsManager.iconLandscape),
],
),
],
),
),


],
),
),
);*/