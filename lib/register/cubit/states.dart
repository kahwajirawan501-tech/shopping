import 'package:flutter/material.dart';
import 'package:shopping/models/shop_app/login_model.dart';

abstract class ShopRegisterState{}
class ShopRegisterInitialState extends ShopRegisterState{}
class ShopRegisterLoadingState extends ShopRegisterState{}
class ShopRegisterSuccessState extends ShopRegisterState{
  final ShopLoginModel registerModel;

  ShopRegisterSuccessState(this.registerModel);
}
class ShopRegisterErrorState extends ShopRegisterState{
  final String error;
  ShopRegisterErrorState(this.error);

}
class ShopRegisterChangePassWordVisibilityState extends ShopRegisterState{}

