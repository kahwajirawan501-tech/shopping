import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/models/shop_app/login_model.dart';
import 'package:shopping/register/cubit/states.dart';
import 'package:shopping/shared/network/end_points.dart';
import 'package:shopping/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState>{
  ShopRegisterCubit():super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  late ShopLoginModel registerModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
}){//هل لح اكتبن بايدي طبعا لا لح اخدن من اليوزر
    emit(ShopRegisterLoadingState());
    print('loading');
    DioHelper.postData(

        url:REGISTER,
        data:{//post=>body=>from_data
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        }).then((value){
          // print('finesh');
           print(value.data);
           registerModel= ShopLoginModel.fromJson(value.data);
          // print(loginModel.message);
          emit(ShopRegisterSuccessState(registerModel));
    }).catchError((error){
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
   IconData suffix=Icons.visibility_outlined;
   bool isPasswordShown=true;
  void changePasswordVisibility(){
    isPasswordShown=!isPasswordShown;
    suffix=isPasswordShown?Icons.visibility_outlined:Icons.visibility_off_outlined;
   emit(ShopRegisterChangePassWordVisibilityState ());
  }
















}