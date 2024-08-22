
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/cateogries/cateogries_screen.dart';
import 'package:shopping/cubit/states.dart';
import 'package:shopping/favorites/favorites_screen.dart';
import 'package:shopping/models/categories_model.dart';
import 'package:shopping/models/change_favorites.dart';
import 'package:shopping/models/favorites_model.dart';
import 'package:shopping/models/home_models.dart';
import 'package:shopping/models/shop_app/login_model.dart';
import 'package:shopping/products/products_screen.dart';
import 'package:shopping/settings/settings_screen.dart';
import 'package:shopping/shared/components/constant.dart';
import 'package:shopping/shared/network/end_points.dart';
import 'package:shopping/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<Widget>bottomScreen=[
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottom(int index){
    currentIndex=index;
    emit(ShopChangeBottomNavState());


  }
  HomeModel? homeModel;
  //id   true found,false not found
  Map<int,bool>favorites={};
  void getHomeData(){
    emit(ShopLoadingHomeDateState());
    print('ok');
    DioHelper.getData(
        url:'https://student.valuxapps.com/api/home',
        token: token,
    ).then((value)
    {
      print("okay");
     //print(value.data);

      homeModel=HomeModel.fromJson(value.data);
      //print(homeModel!.data!.products[1].name);
      //print(homeModel!.data!.products[1].price);
   //  print('program');
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id!:element.inFavorite!
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDateState());
    }
    ).catchError((error){
        print(error.toString());
      emit(ShopErrorHomeDateState());
    });
  }
  CategoriesModel? categoriesModel;
  void getCategories(){
   // emit(ShopLoadingHomeDateState());

    DioHelper.getData(
      url:CATEGORIES,
      token: token,
    ).then((value)
    {
      print("okay");
      //print(value.data);

      categoriesModel=CategoriesModel.fromJson(value.data);
      //print(homeModel!.data!.products[1].name);
      //print(homeModel!.data!.products[1].price);
      //  print('program');
      emit(ShopSuccessCategoriesDateState());
    }
    ).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesDateState());
    });
  }
  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId){
    favorites[productId]=!favorites[productId]!;
    emit(ShopChangeFavoritesDateState());//غير الضو قبل ما يدخل

    DioHelper.postData(url:FAVORITES, data: {
      'product_id':productId,
    },token: token)
   .then((value){
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
    if(!changeFavoritesModel!.status!){//اذا التوكين خطا
      favorites[productId]=!favorites[productId]!;

    }
    else{
      getFavorites();
    }
    emit(ShopSuccessChangeFavoritesDateState(changeFavoritesModel!));

    }).catchError((error){
      favorites[productId]=!favorites[productId]!;
    emit(ShopErrorChangeFavoritesDateState());
    });

  }
  FavoritesModel? favoritesModel;
  void getFavorites(){
   emit( ShopLoadingGetFavoritesDateState());
    DioHelper.getData(
      url:FAVORITES,
      token: token,
    ).then((value)
    {
       print("okay");
      //  print(value.data);

      favoritesModel=FavoritesModel.fromJson(value.data);
        emit(ShopSuccessGetFavoritesDateState());
    }
    ).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesDateState());
    });
  }
  ShopLoginModel? userModel;
  void getUserData(){
    emit( ShopLoadingUserDateState());
    DioHelper.getData(
      url:PROFILE,
      token: token,
    ).then((value)
    {


      userModel=ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDateState(userModel!));
    }
    ).catchError((error){
      print(error.toString());
      emit(ShopErrorUserDateState());
    });
  }
  void updateUserData({
  required String name,
  required String email,
  required String phone,
}){
    emit( ShopLoadingUpdateUserState());
    DioHelper.putData(
      url:UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
    },

    ).then((value)
    {


      userModel=ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState(userModel!));
    }
    ).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }

}