import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/login/cubit/states.dart';
import 'package:shopping/models/shop_app/login_model.dart';
import 'package:shopping/shared/network/end_points.dart';
import 'package:shopping/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginState>{
  ShopLoginCubit():super(ShopLoginInitialState());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  late ShopLoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
}){//هل لح اكتبن بايدي طبعا لا لح اخدن من اليوزر
    emit(ShopLoginLoadingState());
    print('loading');
    DioHelper.postData(

        url:LOGIN,
        data:{//post=>body=>from_data
          'email':email,
          'password':password,
        }).then((value){
          // print('finesh');
           print(value.data);
          loginModel= ShopLoginModel.fromJson(value.data);
          // print(loginModel.message);
          emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    });
  }
   IconData suffix=Icons.visibility_outlined;
   bool isPasswordShown=true;
  void changePasswordVisibility(){
    isPasswordShown=!isPasswordShown;
    suffix=isPasswordShown?Icons.visibility_outlined:Icons.visibility_off_outlined;
   emit(ShopChangePassWordVisibilityState ());
  }
















}