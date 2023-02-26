import 'package:flutter/material.dart';

abstract class BottomNavBarStates{}
class BottomNavBarChangeStates extends BottomNavBarStates{
  int currentIndex;
  Widget selectedScreen;
  BottomNavBarChangeStates({
    required this.currentIndex,
    required this.selectedScreen
});
}
