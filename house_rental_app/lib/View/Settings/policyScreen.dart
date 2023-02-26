import 'package:flutter/material.dart';

import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';
import 'package:newproject/View/space/BottomNavigationBarScreen/moreScreen.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';

import '../shared_widget/component.dart';


class PolicyScreen extends StatefulWidget {
  const PolicyScreen();
  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  List policyTitleList=StringsManager.policyTitleList;
  List policySubList=StringsManager.policySubList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: SharedColors.BackGraundColor,
        appBar: AppBar(
          leading: sharedIconButton(
            color: SharedColors.GreykColor ,
            onPressed:(){Navigator.pop(context);} ,
            icon:IconsManager.iconLift,
          ),
          centerTitle: true,
          elevation: AppSize.size0,
          backgroundColor: SharedColors.BackGraundColor,
          title: Text(
            StringsManager.termsAndPolicy,
            style: SharedFonts.primaryOrangeFont,
          ),
        ),
        body: ListView(
          children: [
            /*Container(
              margin: EdgeInsetsDirectional.all(AppSize.size20),
                child: Text(StringsManager.policyDescription,style: SharedFonts.subOrangeFont,)),
            Container(
              margin: EdgeInsetsDirectional.all(AppSize.size20),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(AppSize.size20),
                color: SharedColors.GreykColor,
              ),
              child: Column(
                children: [
                  for(int i=0 ; i<=21; i++)
                  Text(policyDataList[i],style: SharedFonts.primaryBlackFont,),

                ],
              ),
            ),*/
            for(int i=0; i<6 ; i++)
                Column(
                  children: [
                        Text(policyTitleList[i],style: SharedFonts.primaryOrangeFont,),
                  Container(
                      margin: EdgeInsetsDirectional.all(AppSize.size20),
                      padding: EdgeInsetsDirectional.all(AppSize.size20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(AppSize.size20),
                          color: SharedColors.GreykColor,
      ),
                      child: Text(policySubList[i],style: SharedFonts.primaryBlackFont,))
    ]
    ),

          ],
        ),
    );
  }}