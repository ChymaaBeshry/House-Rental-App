import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:newproject/Controller/BottomNavBarController/BottomNavBarCubit.dart';
import 'package:newproject/Controller/CategoryController/categoryCubit.dart';
import 'package:newproject/Controller/MapController/mapCubit.dart';
import 'package:newproject/Controller/blocObserver.dart';
import 'package:newproject/Controller/spaceController/spaceCubit.dart';
import 'package:newproject/View/Splash/onBoardingScreen.dart';
import 'package:newproject/View/shared_theme/shared_colors.dart';
import 'View/Settings/aboutUsScreen.dart';
import 'View/Settings/contactUsScreen.dart';
import 'View/Settings/policyScreen.dart';
import 'View/Settings/settingsScreen.dart';
import 'View/Splash/splashScreen.dart';
import 'View/User/loginScreen.dart';
import 'View/User/personalInfoScreen.dart';
import 'View/User/profileScreen.dart';
import 'View/User/signUpScreen.dart';
import 'View/User/userShowApartmentScreen.dart';
import 'View/space/BottomNavigationBarScreen/bottomNavBarScreen.dart';
import 'View/space/BottomNavigationBarScreen/favoriteScreen.dart';
import 'View/space/BottomNavigationBarScreen/locationScreen.dart';
import 'View/space/BottomNavigationBarScreen/moreScreen.dart';




void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> CategoryCubit(),),
        BlocProvider(create: (context)=> SpaceCubit(),),
        BlocProvider(create: (context)=> BottomNavBarCubit(),),
        BlocProvider(create: (context)=> MapController(),),
      ],
      child: MaterialApp(
        routes: {
          "login":(BuildContext) =>const LoginScreen(),
          "sign":(BuildContext)=>const SignUpScreen(),
          "bottom":(BuildContext)=>const BottomNavBarScreen(),
          "more":(BuildContext)=>const MoreScreen(),
          "favorite":(BuildContext)=>const FavoriteScreen(),
          "account":(BuildContext)=>const ProfileScreen(),
          "settings":(BuildContext)=>const SettingsScreen(),
          "contact":(BuildContext)=>const ContactUsScreen(),
          "policy":(BuildContext)=>const PolicyScreen(),
          "about":(BuildContext)=>const AboutUsScreen(),
          "personalInfo":(BuildContext)=>const PersonalInfoScreen(),
          "userShow":(BuildContext)=>const UserShowApartmentScreen(),
          "boarding":(BuildContext)=>const OnBoardingScreen(),
        },
        theme: ThemeData(
          primaryColor: SharedColors.OrangeColor,
          primarySwatch: Colors.grey,
        ),
        debugShowCheckedModeBanner: false,
        home:const SplashScreen()



      ),
    );
  }
}
