import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/imageManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';
import 'package:newproject/view/shared_widget/component.dart';

import '../../Controller/BottomNavBarController/BottomNavBarCubit.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen();
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String,dynamic>> accountSectionDetails=
  [
    {
      "icon1":IconsManager.iconFavorite,
      "title":StringsManager.favoriteList,
      "title2":"3 ",
      "icon2":IconsManager.iconRight,
      "screen":"favorite"
    },
    {
      "icon1":IconsManager.iconHouse,
      "title":StringsManager.userList,
      "title2":" ",
      "icon2":IconsManager.iconRight,
      "screen":"userShow"
    },
    {
      "icon1":IconsManager.iconAccount,
      "title":StringsManager.personalInfo,
      "title2":" ",
      "icon2":IconsManager.iconRight,
      "screen":"personalInfo"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: SharedColors.BackGraundColor,
        appBar: AppBar(
          leading:   sharedIconButton(
            onPressed: (){
              //BlocProvider.of<BottomNavBarCubit>(context).move(3);
              Navigator.pop(context);

            },
            icon:IconsManager.iconLift,
              color: SharedColors.GreykColor,

          ),
          centerTitle: true,
          elevation:  AppSize.size0,
          backgroundColor: SharedColors.BackGraundColor,
          title: Text(
            StringsManager.profile,
            style: SharedFonts.primaryOrangeFont,
          ),
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("  ${StringsManager.welcome}",style: SharedFonts.primaryBlackFont,),
          Row(
            children: [
              CircleAvatar(
                radius:  AppSize.size40,
                backgroundImage: AssetImage(ImagesManager.personImage),
                //child: Image.network("https://qodebrisbane.com/wp-content/uploads/2019/07/This-is-not-a-person-2-1.jpeg"),
              ),
              Column(
                //mainAxisSize: MainAxisSize.min,
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\n\n  Rana Tarek",style: SharedFonts.primaryBlackFont,),
                  Text("  aranatarek@gmail.com\n\n",style: SharedFonts.primaryGreyFont,),
                ],
              ),
            ],
          ),
          divider(),
          Text("  ${StringsManager.myAccount}",style: SharedFonts.primaryBlackFont,),
          Column(
            children: [
              for(int i=0 ;i<3;i++)
                accountSection1(
                    accountSectionDetails[i]["icon1"],
                    accountSectionDetails[i]["title"],
                    accountSectionDetails[i]["title2"],
                    accountSectionDetails[i]["icon2"],
                    context,
                    accountSectionDetails[i]["screen"]),
            ],
          ),

        ],
      ),
    );
  }

}