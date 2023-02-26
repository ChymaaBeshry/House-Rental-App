import 'package:flutter/material.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';
import 'package:newproject/View/space/BottomNavigationBarScreen/moreScreen.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';

import '../shared_widget/component.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen();
  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}
class _ContactUsScreenState extends State<ContactUsScreen> {

  List contactIcons=[
    IconsManager.iconMessege,
    IconsManager.iconLocation,
    IconsManager.iconPhone,
    IconsManager.iconWatch,
  ];
  List contactTitle=[
    StringsManager.emailApp,
    StringsManager.addressApp,
    StringsManager.phoneApp,
    StringsManager.timeApp,
  ];

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
          elevation:  AppSize.size0,
          backgroundColor: SharedColors.BackGraundColor,
          title: Text(
            StringsManager.contactUs,
            style: SharedFonts.primaryOrangeFont,
          ),
        ),
        body:Column(
          children: [
           //apartmentDetail(contactUsList[0]["title"], contactUsList[0]["icon"]),
            for(int i=0 ; i<=3 ;i++)
            contactSection(contactIcons[i],contactTitle[i]),

          ],
        ),
    );
  }
Container contactSection(IconData icon,String title)=> Container(
  margin: EdgeInsetsDirectional.all( AppSize.size20),
  child: Row(

    children: [
      Icon(icon,color: SharedColors.OrangeColor,size:  AppSize.size25,),
      Text(title,style: SharedFonts.primaryBlackFont,)
    ],
  ),
);
}