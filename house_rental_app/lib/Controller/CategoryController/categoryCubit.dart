import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:newproject/Controller/CategoryController/categoryStates.dart';
import 'package:newproject/Model/categoryModel.dart';

String domain="https://houserentalapp-cf1b3-default-rtdb.firebaseio.com";
class CategoryCubit extends Cubit<CategoryStates> {
  CategoryCubit():super(InitialStateCategory()){
    getCategory();
  }

  List<CategoryModel> _categorise=[];
  List<CategoryModel> get categorise=>_categorise;
  Future<void> getCategory() async{
  try{
    emit(LoadingStateCategory());
    http.Response res =await http.get(Uri.parse("$domain/category.json"));
    if(res.statusCode==200){
      Map data=json.decode(res.body);
      data.forEach((key, value) {
        _categorise.add(
          CategoryModel.fromJson(key, value),
        );
      });
      emit(SuccessStateCategory(_categorise));
    }
    //emit(ErrorStateCategory());

  }catch(error){
    emit(ErrorStateCategory());
    print(error);
  }
    }
}
