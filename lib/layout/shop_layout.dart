import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/cubit/cubit.dart';
import 'package:shopping/cubit/states.dart';
import 'package:shopping/login/shop_login_screen.dart';
import 'package:shopping/search/search_screen.dart';
import 'package:shopping/shared/components/components.dart';
import 'package:shopping/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state){

      },
      builder: (context, state) {
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
                'Salla'

            ),
            actions: [
              IconButton(onPressed:(){
                navigateTo(context: context,widget: const SearchScreen());
              }, icon:const Icon(
                Icons.search_rounded,
              ))
            ],
          ),

          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottom(index);
            },
            elevation: 0.0,
            items:const [
              BottomNavigationBarItem(
                label:'home' ,
                icon:Icon(
                  Icons.home,
                ) ,

              ),
              BottomNavigationBarItem(
                label:'categories' ,
                icon:Icon(
                  Icons.apps,
                ) ,

              ),
              BottomNavigationBarItem(
                label:'favorite' ,
                icon:Icon(
                  Icons.favorite,
                ) ,

              ),
              BottomNavigationBarItem(
                label:'Settings' ,
                icon:Icon(
                  Icons.settings,
                ) ,

              ),
            ],
          ),

        );
      },

    );
  }
}
