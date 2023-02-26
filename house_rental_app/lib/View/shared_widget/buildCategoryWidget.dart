import 'package:flutter/material.dart';
import 'package:newproject/Controller/CategoryController/categoryCubit.dart';
import 'package:newproject/Controller/CategoryController/categoryStates.dart';
import 'package:newproject/Controller/spaceController/spaceCubit.dart';
import 'package:newproject/Model/categoryModel.dart';
import 'package:newproject/View/User/searchScreen.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';
import 'package:newproject/View/shared_theme/share_fonts.dart';
import 'package:newproject/View/shared_theme/shared_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import 'component.dart';
class BuildCategory extends StatefulWidget {
  BuildCategory();

  @override
  State<BuildCategory> createState() => _BuildCategoryState();
}

class _BuildCategoryState extends State<BuildCategory> {
   bool isSelected=false;

  @override
  Widget build(BuildContext context) {
    CategoryCubit categoryController=BlocProvider.of<CategoryCubit>(context);
    return BlocBuilder<CategoryCubit, CategoryStates>(
      builder: (context, CategoryStates state) {
        if (state is LoadingStateCategory) {
          return centerLoading();
        } else if (state is SuccessStateCategory) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>  InkWell(
              onTap: () {
                BlocProvider.of<SpaceCubit>(context).categorySpaces(categoryController.categorise[index]);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen(
                      title: categoryController.categorise[index].categoryName,
                      spaceModel:categoryController.categorise[index].categorySpaces,
                    )));
              },
              child: Container(
                margin: EdgeInsetsDirectional.fromSTEB(
                    AppSize.size10, AppSize.size20, AppSize.size0,
                    AppSize.size0),
                child: Column(
                  children: [
                    Container(
                      height: AppSize.size60,
                      width: AppSize.size60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(
                            AppSize.size50),
                        color: SharedColors.WhiteColor,
                        image: DecorationImage(
                            image: NetworkImage(
                                categoryController.categorise[index].categoryImage),
                            fit: BoxFit.fill
                        ),
                      ),
                    ),
                    Text(categoryController.categorise[index].categoryName,
                        style: SharedFonts.primaryGreyFont)
                  ],
                ),

              ),
            ),
            itemCount:categoryController.categorise.length,
          );
        } else {
          return centerErrorText();
        }
      },
    );
  }
}

/*Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              SearchScreen(state.category[index]
                                  .categoryName)));*/