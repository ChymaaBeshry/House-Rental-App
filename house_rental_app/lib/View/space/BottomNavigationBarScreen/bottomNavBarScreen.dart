import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newproject/Controller/BottomNavBarController/BottomNavBarCubit.dart';
import 'package:newproject/Controller/BottomNavBarController/BottomNavBarStates.dart';
import 'package:newproject/Controller/MapController/mapCubit.dart';
import 'package:newproject/Controller/spaceController/spaceCubit.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';

import '../../shared_widget/component.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen();
  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  final popKey=GlobalKey<PopupMenuButtonState>();

  List<String> Countries=[
    "Helwan",
    "Cairo",
    "Giza",
    "Maadi",
    "Aswan",
    "Aswan",
  ];

  bool isSelectedNotification=false;
String country=StringsManager.country;
  //int selectedIconNav=0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit,BottomNavBarStates>(
        builder: (context , state){
          if(state is BottomNavBarChangeStates){
            return Scaffold(
              backgroundColor: SharedColors.BackGraundColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: SharedColors.TransparentColor,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("  ${StringsManager.location}", style: SharedFonts.primaryOrangeFont ,),
                    Row(
                      children: [
                        Icon(IconsManager.iconLocation,color: SharedColors.OrangeColor,),
                       // Text( BlocProvider.of<MapController>(context).placeMark.country==null?"${StringsManager.country}": "${BlocProvider.of<MapController>(context).placeMark.country.toString()}" , style: SharedFonts.subBlackFont),
                        Text( country, style: SharedFonts.subBlackFont),
                        PopupMenuButton(
                            key: popKey,
                            elevation:  AppSize.size10,
                            icon: Icon(IconsManager.iconDown),
                            itemBuilder:(context)=>[
                              for(int i=0 ; i<5 ; i++)
                                PopupMenuItem(
                                  child: Text(Countries[i] ),
                                  value:Countries[i],
                                  //value: Categorytitle[0] ,
                                ),
                            ],
                          onSelected: (value)async{

                              await BlocProvider.of<MapController>(context).getSearchLocation(value.toString());
                              BlocProvider.of<SpaceCubit>(context).getNearbySpace(
                                  BlocProvider.of<MapController>(context).latlng
                              );
                              country=value.toString();

                          },
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  sharedIconButton(
                      onPressed:(){
                    /*setState(() {
                      isSelectedNotification=!isSelectedNotification;
                    });*/
                  },
                      icon:IconsManager.iconMessege,
                  color: isSelectedNotification==true? SharedColors.OrangeColor:SharedColors.BalckColor,),
                ],
              ),
              body: state.selectedScreen,
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  itemNav(IconsManager.iconHouse,StringsManager.home),
                  itemNav(IconsManager.iconFavorite ,StringsManager.favorite),
                  itemNav(IconsManager.iconLocation,StringsManager.location),
                  itemNav(IconsManager.iconMore,StringsManager.more),
                ],
                elevation:  AppSize.size30,
                selectedIconTheme: IconThemeData(
                  color: SharedColors.OrangeColor,
                  size:  AppSize.size15,
                ),
                unselectedIconTheme: IconThemeData(
                  color: SharedColors.GreykColor,
                  size:  AppSize.size15,
                ),
                type: BottomNavigationBarType.fixed,
                selectedFontSize:  AppSize.size20,
                unselectedFontSize: AppSize.size20,
                selectedLabelStyle: SharedFonts.yellowFont,
                unselectedLabelStyle: SharedFonts.yellowFont,
                currentIndex: state.currentIndex,
                onTap: (i){
                  BlocProvider.of<BottomNavBarCubit>(context).move(i);
                },

              ),

            );
          }else{
            return centerLoading();
          }
        }
        );
  }

  BottomNavigationBarItem itemNav(IconData icon , String title)=>
  BottomNavigationBarItem(
  icon: Icon(icon),
  label: title,
  );
}