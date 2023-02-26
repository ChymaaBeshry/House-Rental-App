import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newproject/Controller/spaceController/spaceCubit.dart';
import 'package:newproject/Controller/spaceController/spaceStates.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';
import 'package:newproject/View/shared_widget/apartmentWidget.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';

class UserShowApartmentScreen extends StatefulWidget {
  const UserShowApartmentScreen();
  @override
  State<UserShowApartmentScreen> createState() =>
      _UserShowApartmentScreenState();
}

class _UserShowApartmentScreenState extends State<UserShowApartmentScreen> {
  final popAddreesKey = GlobalKey<PopupMenuButtonState>();
  @override
  Widget build(BuildContext context) {
    SpaceCubit spaceCubit = BlocProvider.of<SpaceCubit>(context);
    return BlocBuilder<SpaceCubit, SpaceStates>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: SharedColors.BackGraundColor,
          elevation: AppSize.size0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                IconsManager.iconLift,
                color: SharedColors.GreykColor,
              )),
          centerTitle: true,
          title: Text(
            StringsManager.userList,
            style: SharedFonts.primaryOrangeFont,
          ),
        ),
        backgroundColor: SharedColors.BackGraundColor,
        body: Column(
          children: [
            SafeArea(
                child: Text(
              " ${spaceCubit.userSpaces.length} ${StringsManager.items}  ",
              style: SharedFonts.primaryBlackFont,
            )),
            Flexible(
              child: ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    ApartmentWidget(
                      isDetail: false,
                      spaceModel: spaceCubit.userSpaces[index],
                    ),
                  ],
                ),
                itemCount: spaceCubit.userSpaces.length,
              ),
            ),
          ],
        ),
      );
    });
  }
}

/*Scaffold(
      backgroundColor: SharedColors.BackGraundColor,
      appBar: AppBar(
        backgroundColor: SharedColors.BackGraundColor,
        elevation: 0,
        leading: IconButton(onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
        }, icon: Icon(Icons.arrow_circle_left,color: SharedColors.GreykColor,)),
        centerTitle: true,
        title: Text("Address", style: SharedFonts.primaryOrangeFont,),
      ),
      body: Column(
        children: [
          listTilePopUp("Select Country",popAddreesKey,settingsSectionDetails[0]["data"],settingsSectionDetails[0]["data"][0]),
          divider(),
          Container(
            height: 500,
              width: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://www.google.com/maps/d/thumbnail?mid=17Html8AHIeJ2g4ALF1y8d4jKVh4&hl=en"),
                    fit: BoxFit.fill,
                  )
              ),
          ),
          divider(),
        ],

      ),
    );*/
