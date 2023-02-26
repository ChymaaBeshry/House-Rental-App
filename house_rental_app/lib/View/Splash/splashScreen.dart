import 'package:flutter/material.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/View/space/BottomNavigationBarScreen/bottomNavBarScreen.dart';

import '../Utilities/StringManager.dart';
import '../Utilities/imageManager.dart';
import '../Utilities/valuesManager.dart';
import '../shared_theme/share_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context,"boarding");
                },
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child:Image.asset(ImagesManager.logoImage,fit: BoxFit.fill) ,
                ),
              ),
              Text("\n ${StringsManager.onBoarding1}",style: SharedFonts.primaryBlackFont,)

            ],
          ),

      )

    );
  }}