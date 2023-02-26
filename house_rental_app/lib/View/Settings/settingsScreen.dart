import 'package:flutter/material.dart';

import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';
import 'package:newproject/view/shared_widget/component.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen();
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final popKey=GlobalKey<PopupMenuButtonState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: SharedColors.BackGraundColor,
        appBar: AppBar(
          leading: sharedIconButton(
            color:SharedColors.GreykColor ,
            onPressed:(){Navigator.pop(context);} ,
            icon:IconsManager.iconLift,
          ),
          centerTitle: true,
          elevation:AppSize.size0,
          backgroundColor: SharedColors.BackGraundColor,
          title: Text(
            StringsManager.settings,
            style: SharedFonts.primaryOrangeFont,
          ),
        ),
        body: Column(children: [

         for(int i=0 ;i<3;i++)
           accountSection(
             settingsSectionDetails[i]["icon1"],
             settingsSectionDetails[i]["title"],
             settingsSectionDetails[i]["title2"],
             settingsSectionDetails[i]["notification"],
             settingsSectionDetails[i]["key"],
             settingsSectionDetails[i]["data"],
             context),

        ],),
    );
  }
}