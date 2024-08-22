import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/cubit/cubit.dart';
import 'package:shopping/cubit/states.dart';
import 'package:shopping/layout/shop_layout.dart';
import 'package:shopping/login/shop_login_screen.dart';
import 'package:shopping/modules/on_boarding.dart';
import 'package:shopping/shared/components/constant.dart';
import 'package:shopping/shared/network/local/cache_helper.dart';
import 'package:shopping/shared/network/remote/dio_helper.dart';
import 'package:shopping/shared/styles/themes.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
   await CacheHelper.init();
   Widget widget;
    bool onBoarding =CacheHelper.getData(key:'onBoarding') ?? false;
     token =CacheHelper.getData(key:'token');
//print(token);//1 null
//print(onBoarding);// 1 false
  if(onBoarding==true){
    if(token==null) {//finish login//!=
      widget=const ShopLayout();
    //  print(token);
    }
    else{//انا خلصت ال onBoarding   بس ماخلصت ال login
      widget=ShopLoginScreen();
    }
  }else{
    widget=OnBoardingScreen();
    //print(onBoarding);
  }

  runApp( MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
   const MyApp( {required this.startWidget,super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create:(context) => ShopCubit()..getHomeData()..getCategories()..getFavorites(),

        )
      ],
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener:(context, state){},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:lightTheme,

            home:startWidget,
          );
        },
      ),

      );

  }



}
