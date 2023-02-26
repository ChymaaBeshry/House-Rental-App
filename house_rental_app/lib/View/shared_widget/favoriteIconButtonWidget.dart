import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newproject/Controller/spaceController/spaceCubit.dart';
import 'package:newproject/Model/spaceModel.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/shared_theme/shared_colors.dart';

import 'component.dart';
class FavoriteIconButtonWidget extends StatefulWidget {
  FavoriteIconButtonWidget(this.spaceModel);
  SpaceModel spaceModel;

  @override
  State<FavoriteIconButtonWidget> createState() => _FavoriteIconButtonWidgetState();
}

 class _FavoriteIconButtonWidgetState extends State<FavoriteIconButtonWidget> {

  @override
  Widget build(BuildContext context) {
    return  sharedIconButton(onPressed: () {
      BlocProvider.of<SpaceCubit>(context).handleFavorite(widget.spaceModel);
      ScaffoldMessenger.of(context).showSnackBar(
        snack(title: "process Successfully",color: SharedColors.greenColor),
      );
    }, icon:IconsManager.iconFavorite,
      color: widget.spaceModel.favorite == true
          ? SharedColors.OrangeColor
          : SharedColors.BalckColor,);
  }
}
