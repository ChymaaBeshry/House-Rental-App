import 'package:flutter/material.dart';
import 'package:newproject/Model/spaceModel.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';
import 'package:newproject/View/shared_widget/favoriteIconButtonWidget.dart';
import 'package:newproject/View/shared_widget/sectionEditDeleteUserApartment.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';
import 'package:newproject/View/space/detailsScreen.dart';
import 'package:newproject/view/shared_widget/component.dart';

class ApartmentWidget extends StatefulWidget {
  bool isDetail;
  ApartmentWidget({
    required this.isDetail,
    required this.spaceModel
});
SpaceModel spaceModel;

  @override
  State<ApartmentWidget> createState() => _ApartmentWidgetState();
}

class _ApartmentWidgetState extends State<ApartmentWidget> {
  @override
  Widget build(BuildContext context) {
   // SpaceCubit spaceCubit = BlocProvider.of<SpaceCubit>(context);
    return Container(
      margin: EdgeInsetsDirectional.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(20),
        color:widget.isDetail == false? SharedColors.WhiteColor:SharedColors.BackGraundColor,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: widget.isDetail == false ? () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return DetailsScreen(widget.spaceModel);
                  },));
            } : () {},
            child: Container(
              height: AppSize.size150,
              width: 260,
              decoration: BoxDecoration(
                color: SharedColors.WhiteColor,
                borderRadius: BorderRadiusDirectional.circular(
                    20),
                image: DecorationImage(
                  image: NetworkImage(
                      widget.spaceModel.spaceImgs[0]),
                  fit: BoxFit.fill,
                ),
              ),
              alignment: Alignment.topRight,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.spaceModel.spaceName,
                style: SharedFonts.primaryBlackFont,),
              Text("${widget.spaceModel.spacePrice}/${widget.spaceModel.rentType}", style: SharedFonts
                  .primaryOrangeFont),
            ],
          ),
          apartmentDetail(widget.spaceModel.spaceLocation, IconsManager.iconLocation),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              apartmentDetail(" ${widget.spaceModel
                  .spaceBeds} bed  ", IconsManager.iconBed),
              apartmentDetail(" ${widget.spaceModel
                  .spaceBathRoom} bath  ", IconsManager
                  .iconBathroom),
              apartmentDetail("${widget.spaceModel
                  .spaceArea} km  ", IconsManager
                  .iconLandscape),
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
              widget.spaceModel.userId=="1"? SectionEditDeleteUserApartment(widget.spaceModel):
              widget.isDetail == false?FavoriteIconButtonWidget(widget.spaceModel):SizedBox(),

            ],
          ),
        ],
      ),
    );
  }

}
