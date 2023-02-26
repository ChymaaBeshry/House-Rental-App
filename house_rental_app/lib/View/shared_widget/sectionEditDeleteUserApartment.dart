import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newproject/Controller/spaceController/spaceCubit.dart';
import 'package:newproject/Model/spaceModel.dart';
import 'package:newproject/View/User/userUpdateApartmentScreen.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/shared_widget/component.dart';

import '../shared_theme/shared_colors.dart';

class SectionEditDeleteUserApartment extends StatelessWidget {
  SpaceModel spaceModel;
  SectionEditDeleteUserApartment(this.spaceModel);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        sharedIconButton(
            icon: IconsManager.iconEdit,
            color:  SharedColors.OrangeColor,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserUpdateApartmentScreen(
                spaceModel:spaceModel ,
              )));

            }),
        sharedIconButton(
            color:  SharedColors.OrangeColor,
            icon: IconsManager.iconDelete,
            onPressed: (){
              BlocProvider.of<SpaceCubit>(context).deleteSpace(spaceModel);
            })
      ],
    );
  }
}
