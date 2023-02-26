import 'package:flutter/material.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';
import 'package:newproject/View/shared_widget/inputFeildWidget.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/view/shared_widget/component.dart';

import '../space/BottomNavigationBarScreen/bottomNavBarScreen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController resetemailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();

  final emailKey=GlobalKey<ScaffoldState>();
  final passwordKey=GlobalKey<ScaffoldState>();
  final phoneKey=GlobalKey<ScaffoldState>();
  final resetemailKey=GlobalKey<ScaffoldState>();

  final formKey=GlobalKey<FormState>();

  bool pressesd = true;
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column (
        children:[
          SafeArea(
            child: Container(
              width: double.infinity,
              height: AppSize.size150,
              decoration: BoxDecoration(
                color: SharedColors.GreykColor ,
                borderRadius:BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(AppSize.size70),
                  bottomStart:  Radius.circular(AppSize.size70),
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(StringsManager.welcome,style: SharedFonts.primaryOrangeFont ,),
                  Text(StringsManager.onBoarding1,style: SharedFonts.primaryOrangeFont),
                ],
              ),
            ),
          ),
          Flexible(
            child: Container(
                margin: EdgeInsetsDirectional.only(top: AppSize.size10 , start:  AppSize.size30 ,end:  AppSize.size30),
                width: double.infinity,
                child:Form(
                  key:formKey ,
                  child: ListView(
                    children: [
                      titleSection(StringsManager.email ),
                      InputField(
                        model: InputModel(
                            key: emailKey,
                            keyboardType:  TextInputType.emailAddress ,
                            controller:  emailController,
                            title:  StringsManager.userName,
                            prefix:  IconsManager.iconEmail
                        ),
                      ),
                      titleSection(StringsManager.password ),
                      InputField(
                        model: InputModel(
                            key: passwordKey,
                            keyboardType:  TextInputType.visiblePassword ,
                            controller:  passwordController,
                            title:  StringsManager.password,
                            prefix:  IconsManager.iconLock,
                          isSecure: true

                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(onChanged:(value){ setState(()  { check=value! ; });} , value: check ,
                                activeColor: SharedColors.GreykColor,
                                hoverColor:SharedColors.OrangeColor,
                                focusColor:  SharedColors.BalckColor,
                                checkColor: SharedColors.OrangeColor,

                              ),
                              Text(StringsManager.remember,style:SharedFonts.subGreyFont),
                            ],
                          ),
                          InkWell(
                            onTap:(){
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(StringsManager.forgotYourPassword,style: SharedFonts.subOrangeFont,) ,
                                    content:Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InputField(
                                          model: InputModel(
                                             key: resetemailKey,
                                             keyboardType:  TextInputType.emailAddress ,
                                              controller:  resetemailController,
                                              title:  StringsManager.userName,
                                              prefix:  IconsManager.iconEmail
                                          ),
                                        ),
                                        InputField(
                                          model: InputModel(
                                              key: phoneKey,
                                              keyboardType: TextInputType.name ,
                                              controller:  phoneController,
                                              title:StringsManager.phoneNumber,
                                              prefix:   IconsManager.iconPhone
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      textButton(
                                        onPressed:  (){
                                          Navigator.pop(context);
                                        },
                                        title:StringsManager.cancel ,
                                      ),
                                      textButton(
                                        onPressed:(){} ,
                                        title:StringsManager.send,),
                                    ],
                                  );
                                } ,
                              );
                            },
                            child: Text(StringsManager.forgotPassword ,style: SharedFonts.subOrangeFont ),),

                        ],
                      ),
                      sharedButton(
                         title: StringsManager.login ,
                            onPressed:   (){
                              Navigator.pushNamedAndRemoveUntil(context, "bottom", (route) => false);
                            }

                      ),
                      OR(),
                      faceGoogle(StringsManager.signInWith),
                      TextButton(
                        onPressed: ()  {
                             Navigator.pushNamed(context, "sign");

                        },
                        child:Row(
                        children: [
                          Text(StringsManager.dontHaveAccount, style:SharedFonts.subBlackFont),
                          Text(StringsManager.signUp, style:SharedFonts.primaryOrangeFont,textAlign: TextAlign.center,),
                        ],
                      ),

                      ),
                    ],

                  ),
                ),
              ),
          ),
    ]
      ),


    );
  }


}