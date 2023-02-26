
import 'package:flutter/material.dart';
import 'package:newproject/Controller/MapController/mapCubit.dart';
import 'package:newproject/Controller/spaceController/spaceCubit.dart';
import 'package:newproject/Controller/spaceController/spaceStates.dart';
import 'package:newproject/View/shared_widget/apartmentWidgetVertial.dart';
import 'package:newproject/View/shared_widget/buildCategoryWidget.dart';
import 'package:newproject/View/shared_widget/floatingActionButtonWidget.dart';
import 'package:newproject/view/shared_widget/apartmentWidget.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';
import 'package:newproject/View/User/searchScreen.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared_widget/component.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen();
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

@override
  void initState() {
  BlocProvider.of<SpaceCubit>(context).getNearbySpace(BlocProvider.of<MapController>(context).latlng);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SpaceCubit spaceCubit = BlocProvider.of<SpaceCubit>(context);

    return BlocBuilder<SpaceCubit,SpaceStates>(
      builder:(context, state){
        if (state is LoadingSpaceState) {
          return centerLoading();
        }else if(state is ErrorSpaceState ){
          return centerErrorText();
        }else {
          return  RefreshIndicator(
            color: SharedColors.OrangeColor,
            strokeWidth: AppSize.size3,
            onRefresh: (){
              return spaceCubit.getSpaces();
            },
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: SharedColors.BackGraundColor,
              body: ListView(
                children: [
                  Container(
                    height: AppSize.size120,
                    child:BuildCategory(),
                  ),
                  moreTitle(StringsManager.recommended,StringsManager.more),
                  Container(
                    margin: EdgeInsetsDirectional.fromSTEB(
                        AppSize.size10, AppSize.size0, AppSize.size0, AppSize.size0),
                    height: AppSize.size300,
                    width: AppSize.size250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>ApartmentWidget(
                          isDetail: false,
                          spaceModel: spaceCubit.spaces[index]),
                      itemCount: spaceCubit.spaces.length,
                    ),
                  ),
                  moreTitle(StringsManager.nearbyYourLocation, StringsManager.more),
                for(int i=0 ; i<BlocProvider.of<SpaceCubit>(context).nearbyList.length; i++)
                ApartmentWidgetVertical(
            isDetail: false,
            spaceModel: BlocProvider.of<SpaceCubit>(context).nearbyList[i],
          ),
                ],
              ),
              floatingActionButton: FloatingActionButtonWidget(scaffoldKey),
            ),
          );
        }
      }
    );
  }



  ListTile moreTitle(String title, String trailing,) => ListTile(
        title: Text("$title", style: SharedFonts.primaryBlackFont,),
        trailing: Text("$trailing", style: SharedFonts.subGreyFont,),
        onTap: () {
          BlocProvider.of<SpaceCubit>(context).getRecommendedSpaces();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SearchScreen(
                title: title,
                spaceModel: BlocProvider.of<SpaceCubit>(context).recommendedSpaceList,
              )));
        },
      );


}