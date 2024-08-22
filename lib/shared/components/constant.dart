import 'package:shopping/login/shop_login_screen.dart';
import 'package:shopping/shared/components/components.dart';
import 'package:shopping/shared/network/local/cache_helper.dart';

void signOut(context){// for signOut
  CacheHelper.removeData(key: 'token').then((value){
    if(value){
      navigateAndFinish(context: context,widget:ShopLoginScreen() );
    }
  });
}
void printFullText(String text){
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));

}
dynamic token='';