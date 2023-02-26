import 'package:flutter/material.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';
import 'package:newproject/View/space/BottomNavigationBarScreen/moreScreen.dart';

import '../shared_widget/component.dart';


class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen();

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
 static List<dynamic> aboutUsList=StringsManager.aboutUsList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: SharedColors.BackGraundColor,
        appBar: AppBar(
          leading: sharedIconButton(
              color:  SharedColors.GreykColor ,
              onPressed:(){Navigator.pop(context);} ,
              icon:IconsManager.iconLift,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: SharedColors.BackGraundColor,
          title: Text(
            StringsManager.aboutUS,
            style: SharedFonts.primaryOrangeFont,
          ),
        ),
        body: Column(
          children: [
                for(int i=0 ; i<=4 ; i++)
                  aboutUsSection(i),

          ],
        ),
    );
  }
Row aboutUsSection(index)=>Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children:[
    Text(aboutUsList[index],style: SharedFonts.primaryBlackFont,),
    sharedIconButton(
      color:  SharedColors.OrangeColor ,
      onPressed:(){} ,
      icon:IconsManager.iconRight,
    ),

  ],
);
}