import 'package:flutter/material.dart';
import 'package:newproject/Model/spaceModel.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';
import 'package:newproject/View/shared_widget/apartmentWidget.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';

import '../shared_widget/component.dart';
class SearchScreen extends StatefulWidget {

  final title;
  List<SpaceModel> spaceModel;
  SearchScreen({
    required this.title,
    required this.spaceModel
});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SharedColors.BackGraundColor,
      appBar: AppBar(
        elevation: AppSize.size0,
        backgroundColor: SharedColors.BackGraundColor,
        leading: sharedIconButton(onPressed:(){
          Navigator.pop(context);
        }, icon: IconsManager.iconLift,
          color: SharedColors.GreykColor,),
        centerTitle: true,
        title: Text(widget.title, style: SharedFonts.primaryOrangeFont,),
        actions: [
          sharedIconButton(
            onPressed: () {},
            icon: IconsManager.iconSearch,
            color: SharedColors.GreykColor,
          )
        ],
      ),
      body: Column(
        children: [
          SafeArea(
              child: Text(
                " ${widget.spaceModel.length} ${StringsManager.items}  ",
                style: SharedFonts.primaryBlackFont,
              )),
          Flexible(
            child: ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  ApartmentWidget(
                    isDetail: false,
                    spaceModel: widget.spaceModel[index],
                  ),
                ],
              ),
              itemCount: widget.spaceModel.length,
            ),
          ),
        ],
      ),

    );
  }
}

