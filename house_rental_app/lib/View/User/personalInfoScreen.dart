
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';
import 'package:newproject/view/shared_widget/component.dart';

import '../Utilities/imageManager.dart';
class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen();
  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  //File? _image;
  List infoList=[
    {
      "title":"\n  Rana Tarek",
      "subTitle":"  aranatarek@gmail.com\n",
    },
    {
      "title":"\n  First Name",
      "subTitle":"  Rana\n",
    },
    {
      "title":"\n  Last Name",
      "subTitle":"  Tarek\n",
    },
    {
      "title":"\n  E-Mail",
      "subTitle":"  aranatarek@gmail.com\n",
    },
    {
      "title":"\n  Language",
      "subTitle":"   Arabic\n  ",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SharedColors.BackGraundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: AppSize.size0,
        backgroundColor: SharedColors.BackGraundColor,
        title: Text(
          StringsManager.myAccount,
          style: SharedFonts.primaryOrangeFont,
        ),
        leading:  sharedIconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon:IconsManager.iconLift,color: SharedColors.GreykColor,

        ),

      ),
      body: ListView(
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Padding(
               padding: EdgeInsetsDirectional.all(AppSize.size5),
           child:  CircleAvatar(
             radius:  AppSize.size50,
             backgroundImage:AssetImage(ImagesManager.personImage),
             //child: Image.network("https://qodebrisbane.com/wp-content/uploads/2019/07/This-is-not-a-person-2-1.jpeg"),
           ),),
            CircleAvatar(
              radius: AppSize.size40,
              child:sharedIconButton(
                icon:IconsManager.iconCamera,
                color: SharedColors.BalckColor,
                onPressed: (){
                  pickImage();
                },
            ),
            ),
          ],
        ),
          infoSection(
              infoList[0]["title"],
              infoList[0]["subTitle"],
            ),
          divider(),
          Container(
            margin: EdgeInsetsDirectional.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(20),
              color: SharedColors.WhiteColor,

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for(int i=1; i<5; i++)
                  infoSection(
                  infoList[i]["title"],
                  infoList[i]["subTitle"],
                ),
              ],
            ),
          ),
          divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("  ${StringsManager.securityInformation}",style: SharedFonts.primaryBlackFont,),
              sharedButton(
                 title:StringsManager.changePassword ,
                 onPressed: (){} )
            ],
          ),
        ],
      ),


    );
  }
  Column infoSection(String title,String subTitle)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(title,style: SharedFonts.primaryOrangeFont,),
      Text(subTitle,style: SharedFonts.subBlackFont,),
    ],
  );
  Future pickImage() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      //_image = File( [] ,xFile!.path);
      });
  }


}
