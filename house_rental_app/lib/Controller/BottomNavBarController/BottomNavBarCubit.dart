import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:newproject/Controller/BottomNavBarController/BottomNavBarStates.dart';
import 'package:newproject/View/space/BottomNavigationBarScreen/favoriteScreen.dart';
import 'package:newproject/View/space/BottomNavigationBarScreen/homePageScreen.dart';
import 'package:newproject/View/space/BottomNavigationBarScreen/locationScreen.dart';
import 'package:newproject/View/space/BottomNavigationBarScreen/moreScreen.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarStates> {
  BottomNavBarCubit():super(BottomNavBarChangeStates(
      currentIndex: 0,
      selectedScreen: HomePageScreen()));
  final List<Widget> screens=[
    HomePageScreen(),
    FavoriteScreen(),
    LocationScreen(),
    MoreScreen(),
  ];


void move(int index){
  emit(BottomNavBarChangeStates(currentIndex: index, selectedScreen: screens[index]));
}


}