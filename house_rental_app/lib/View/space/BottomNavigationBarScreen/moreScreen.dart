import 'package:flutter/material.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';

import '../../shared_widget/component.dart';



class MoreScreen extends StatefulWidget {
  const MoreScreen();
  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  List<Map<String,dynamic>> moreSectionDetails=
  [
    {
      "icon1":IconsManager.iconAccount,
      "title":StringsManager.account,
      "icon2":IconsManager.iconRight,
      "screen":"account",
    },
    {
      "icon1":IconsManager.iconSettings,
      "title":StringsManager.settings,
      "icon2":IconsManager.iconRight,
      "screen":"settings",
    },
    {
      "icon1":IconsManager.iconContact,
      "title":StringsManager.contactUs,
      "icon2":IconsManager.iconRight,
      "screen":"contact",
    },
    {
      "icon1":IconsManager.iconInfo,
      "title":StringsManager.aboutUS,
      "icon2":IconsManager.iconRight,
      "screen":"about",
    },
    {
      "icon1":IconsManager.iconPolicy,
      "title":StringsManager.termsAndPolicy,
      "icon2":IconsManager.iconRight,
      "screen":"policy",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: SharedColors.BackGraundColor,
      body:
          ListView.builder(
            itemBuilder:(context,i)=>buildMoreSection(moreSectionDetails[i]["icon1"] ,moreSectionDetails[i]["title"], moreSectionDetails[i]["icon2"], moreSectionDetails[i]["screen"]),
            itemCount: moreSectionDetails.length,
          )
          //for(int i=0 ; i< 5 ; i++)
          //buildMoreSection(moreSectionDetails[i]["icon1"] ,moreSectionDetails[i]["title"], moreSectionDetails[i]["icon2"],i),



    );
  }

  Container buildMoreSection(IconData icon1, String title , IconData icon2, String screen)=>Container(
    margin: EdgeInsetsDirectional.all( AppSize.size20),
    padding: EdgeInsetsDirectional.only(
      start: AppSize.size15,
    ),
    decoration: BoxDecoration(
        color: SharedColors.WhiteColor,
        borderRadius: BorderRadiusDirectional.circular( AppSize.size20)

    ),
    height: AppSize.size100,
    child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(  icon1  ,color: SharedColors.OrangeColor,size:  AppSize.size20,),
        Text(  title ,style: SharedFonts.primaryBlackFont,),
        sharedIconButton(
            onPressed: (){
              Navigator.pushNamed(context,screen);

            }
            ,icon: icon2 ,
          color: SharedColors.OrangeColor,),
      ],
    ),
  );

}