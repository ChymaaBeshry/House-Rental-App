import 'package:newproject/Model/categoryModel.dart';

abstract class CategoryStates{}
class InitialStateCategory extends CategoryStates{}
class LoadingStateCategory extends CategoryStates{}
class SuccessStateCategory extends CategoryStates{
  List<CategoryModel> category;
  SuccessStateCategory(this.category);
}
class ErrorStateCategory extends CategoryStates{
}