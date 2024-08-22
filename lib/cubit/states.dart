import 'package:shopping/models/change_favorites.dart';
import 'package:shopping/models/shop_app/login_model.dart';

abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}
class ShopLoadingHomeDateState extends ShopStates{}
class ShopSuccessHomeDateState extends ShopStates{}
class ShopErrorHomeDateState extends ShopStates{}
class ShopSuccessCategoriesDateState extends ShopStates{}
class ShopErrorCategoriesDateState extends ShopStates{}

class ShopSuccessChangeFavoritesDateState extends ShopStates{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesDateState(this.model);

}
class ShopErrorChangeFavoritesDateState extends ShopStates{}
class ShopChangeFavoritesDateState extends ShopStates{}
class ShopSuccessGetFavoritesDateState extends ShopStates{}
class ShopLoadingGetFavoritesDateState extends ShopStates{}
class ShopErrorGetFavoritesDateState extends ShopStates{}
class ShopSuccessUserDateState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUserDateState(this.loginModel);
}
class ShopLoadingUserDateState extends ShopStates{}
class ShopErrorUserDateState extends ShopStates{}

class ShopSuccessUpdateUserState extends ShopStates{
final ShopLoginModel loginModel;

ShopSuccessUpdateUserState(this.loginModel);
}
class ShopLoadingUpdateUserState extends ShopStates{}
class ShopErrorUpdateUserState extends ShopStates{}