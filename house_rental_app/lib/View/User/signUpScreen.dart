import 'package:flutter/material.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';
import 'package:newproject/View/shared_widget/inputFeildWidget.dart';
import 'package:newproject/view/User/loginScreen.dart';
import 'package:newproject/View/space/BottomNavigationBarScreen/bottomNavBarScreen.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/view/shared_widget/component.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen();
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final nameKey = GlobalKey<ScaffoldState>();
  final emailKey = GlobalKey<ScaffoldState>();
  final passwordKey = GlobalKey<ScaffoldState>();
  final confirmPasswordKey = GlobalKey<ScaffoldState>();
  final phoneKey = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SharedColors.BackGraundColor,
      appBar: AppBar(
        backgroundColor: SharedColors.BackGraundColor,
        elevation: 0,
        leading: sharedIconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:IconsManager.iconLift,
              color: SharedColors.GreykColor,
            ),
        centerTitle: true,
        title: Text(
          StringsManager.signUp,
          style: SharedFonts.primaryOrangeFont,
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Text(
              StringsManager.createYourAccount,
              style: TextStyle(
                  color: SharedColors.OrangeColor, fontSize: AppSize.size30),
              textAlign: TextAlign.center,
            ),
            titleSection(StringsManager.name),
            InputField(
              model: InputModel(
                  key: nameKey,
                  keyboardType: TextInputType.text,
                  controller: nameController,
                  title: StringsManager.fullName,
                  prefix: IconsManager.iconPerson),
            ),
            titleSection(StringsManager.email),
            InputField(
              model: InputModel(
                  key: emailKey,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  title: StringsManager.userName,
                  prefix: IconsManager.iconEmail),
            ),
            titleSection(StringsManager.password),
            InputField(
              model: InputModel(
                  key: passwordKey,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  title: StringsManager.password,
                  prefix: IconsManager.iconLock,
                  isSecure: true
              ),
            ),
            titleSection(StringsManager.confirmPassword),
            InputField(
              model: InputModel(
                  key: confirmPasswordKey,
                  keyboardType: TextInputType.visiblePassword,
                  controller: confirmPasswordController,
                  title: StringsManager.confirmPassword,
                  prefix: IconsManager.iconLock,
                  isSecure: true
              ),
            ),
            titleSection(StringsManager.phoneNumber),
            InputField(
              model: InputModel(
                  key: phoneKey,
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  title: StringsManager.phone,
                  prefix: IconsManager.iconPhone),
            ),
            sharedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, "bottom", (route) => false);
                },
                title: StringsManager.signUp),
            /*   sharedButton(
                 title: StringsManager.signUp ,
                   onPressed:  (){

                   Navigator.push(context, MaterialPageRoute(
                     builder: (context)=>BottomNavBarScreen(),

                   ));
                    }

                ),*/

            Text(
              StringsManager.acceptPolicy,
              style: SharedFonts.subBlackFont,
              textAlign: TextAlign.center,
            ),
            OR(),
            faceGoogle(StringsManager.signInWith),
          ],
        ),
      ),
    );
  }
}
/*   if(formKey.currentState!.validate() &&  passwordController.text == confirmPasswordController.text ) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavBarScreen())
                        );
                      }
                      else if(passwordController.text != confirmPasswordController.text ){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text( StringsManager.passwordDoesntExist)));

                      }

                      else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(StringsManager.pleaseEnterYourInfo)));

                      }*/
