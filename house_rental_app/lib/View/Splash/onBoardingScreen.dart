import 'package:flutter/material.dart';
import 'package:newproject/View/Utilities/imageManager.dart';
import 'package:newproject/view/User/loginScreen.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:newproject/View/Utilities/StringManager.dart';

import '../Utilities/valuesManager.dart';
import '../shared_widget/component.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen();
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
   List <Map<String,dynamic>> onBoardingData=[
    {
      "title":StringsManager.onBoarding1,
      "subTitle":" \n",
      "image":ImagesManager.on1,

    },
    {
      "title":StringsManager.onBoarding2,
      "subTitle":StringsManager.subOnBoarding2,
      "image":ImagesManager.on2,

    },
    {
      "title":StringsManager.onBoarding3,
      "subTitle":StringsManager.subOnBoarding3,
      "image":ImagesManager.on3,
    }
  ];
   PageController boardController = PageController(initialPage: 0);
   bool isLast=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SharedColors.BackGraundColor,
      body: Column(

        children:[
          textButton(
            onPressed: (){
              Navigator.pushNamed(context, "login");
            },
            title: StringsManager.skip,
          ),
          Expanded(
            child: PageView.builder(
              onPageChanged: (int index){
                if(index== onBoardingData.length-1){
                  setState(() {
                    isLast=true;
                  });
                }else{
                  setState(() {
                    isLast=false;
                  });
                }
              },
              physics: BouncingScrollPhysics(),
              controller: boardController,
            itemBuilder:(context, index) =>itemBuilderForOnBoarding(index),
            itemCount: onBoardingData.length,
            //scrollDirection: Axis.horizontal,

        ),
          ),
          ListTile(
            leading:SmoothPageIndicator(
               controller:boardController ,
               count: onBoardingData.length ,
               effect: ExpandingDotsEffect(
                 activeDotColor: SharedColors.OrangeColor,
                 dotColor:SharedColors.GreykColor ,
                 expansionFactor: 4,
                 dotWidth: 10,
                 spacing: 5,
                 dotHeight: 10,
               ),


             ),
             trailing:TextButton(
              onPressed: (){
                isLast==true? Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen() )):
                boardController.nextPage(
                    duration: Duration(
                      milliseconds: 100,
                    ),
                    curve: Curves.bounceInOut);
              },
              child: Text(StringsManager.next,style: SharedFonts.primaryOrangeFont,),
            ),
          ),
    ]
      ),
    );
  }
  Center itemBuilderForOnBoarding(index)=>   Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(onBoardingData[index]["title"], style:TextStyle(color: SharedColors.BalckColor ,fontWeight: FontWeight.bold,fontSize: 30),),
        Text(onBoardingData[index]["subTitle"],style: SharedFonts.primaryBlackFont,),
        Container(
          height: AppSize.size250,
          width: AppSize.size150,
          child:  Image.asset(onBoardingData[index]["image"]),
        ),
      ],
    ),
  );
}
