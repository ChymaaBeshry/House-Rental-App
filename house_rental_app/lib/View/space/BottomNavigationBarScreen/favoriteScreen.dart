import 'package:flutter/material.dart';
import 'package:newproject/Controller/spaceController/spaceCubit.dart';
import 'package:newproject/Controller/spaceController/spaceStates.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';
import 'package:newproject/view/shared_widget/apartmentWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared_widget/component.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen();
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  Widget build(BuildContext context) {
    SpaceCubit spaceCubit = BlocProvider.of<SpaceCubit>(context);
    return BlocBuilder<SpaceCubit,SpaceStates>(
       builder:(context, state) {
         if (state is LoadingGetFavoriteState) {
           return centerLoading();
         } else if (state is ErrorGetFavoriteState) {
           return centerErrorText();
         } else {
           return Scaffold(
             backgroundColor: SharedColors.BackGraundColor,
             body: Column(
               children: [
                 SafeArea(child: Text(
                   " ${spaceCubit.favoriteList.length} ${StringsManager
                       .items}  ", style: SharedFonts.primaryBlackFont,)),
                 Flexible(
                   child: ListView.builder(itemBuilder: (context, index) =>
                       ApartmentWidget(
                         isDetail: false,
                         spaceModel: spaceCubit.favoriteList[index],
                       ),
                     itemCount: spaceCubit.favoriteList.length,
                   ),
                 ),
               ],
             ),
           );
         }
       }
    );
  }}

/*   ConditionalBuilder(
                    condition: ,
                     builder: (context) => ApartmentWidget(150,index) ,
                     fallback: (context) => Center(child: Text('this is not true')),
         ),*/
