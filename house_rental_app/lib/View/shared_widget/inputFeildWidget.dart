import 'package:flutter/material.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';

import 'component.dart';
class InputModel{
  TextInputType keyboardType;
  TextEditingController controller;
  GlobalKey key;
  Function? onSubmitted=(){};
  Function? validator;
  IconData prefix;
  String title;
  String hint;
  bool isSecure;
  bool outoCorrect;
  String  validateTitle;
  double width;
  InputModel({
    required this.key,
    required this.controller,
    this.title="",
    this.hint="",
    required this.prefix,
    this.isSecure=false,
    this.outoCorrect=true,
    this.keyboardType=TextInputType.text,
    this.onSubmitted,
    this.validator,
    this.validateTitle="",
    this.width=double.infinity,

});

}


class InputField extends StatelessWidget {
  InputField({required this.model});
  InputModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical:AppSize.size10 ,
        horizontal:AppSize.size5,
      ),
      width:model.width ,
      child: TextFormField(
        keyboardType:model.keyboardType,
        controller: model.controller,
        key:model.key ,
        onFieldSubmitted:(x){
          model.onSubmitted!();
        },
        validator:(x){
          if(x!.isEmpty) {
           // model.validator!;
            return model.validateTitle;
          }
        } ,
        obscureText:model.isSecure ,
        autocorrect:model.outoCorrect ,
        decoration:InputDecoration(

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSize.size10)),
          labelText:model.title ,
          labelStyle:SharedFonts.primaryGreyFont ,
          hintText:model.hint ,
          hintStyle:SharedFonts.subGreyFont ,
          prefixIcon: Icon(model.prefix,size: AppSize.size20,color: SharedColors.OrangeColor,),
          suffixIcon:model.keyboardType==TextInputType.visiblePassword?sharedIconButton(
              onPressed:(){
                model.isSecure!=model.isSecure;
              },
              icon: IconsManager.iconEye,
              color:SharedColors.BalckColor):null ,
          errorBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.size20),
            borderSide: BorderSide(
                color:SharedColors.errorColor,
                width: AppSize.sizeD2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.size20),
            borderSide: BorderSide(
                color: SharedColors.OrangeColor,
                width: AppSize.sizeD2,
            ),
          ),
          enabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.size20),
            borderSide: BorderSide(
              width: AppSize.sizeD2,
              color: SharedColors.BalckColor,
            ),
          ),

          )



      ),
    );
  }
}
