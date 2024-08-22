import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/cubit/cubit.dart';
import 'package:shopping/cubit/states.dart';
import 'package:shopping/models/favorites_model.dart';
import 'package:shopping/shared/components/components.dart';
import 'package:shopping/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {

     },
        builder: (context, state) {
          return ConditionalBuilder(
            builder:(context)=> ListView.separated(

              itemBuilder: (context, index) => buildFavoriteItem(ShopCubit.get(context).favoritesModel!.data!.data[index],context),
              separatorBuilder: (context, index) => MyLine(),
              itemCount: ShopCubit
                  .get(context)
                  .favoritesModel!.data!.data.length,

            ),
            condition:state is! ShopLoadingGetFavoritesDateState ,
            fallback:(context)=>Center(child: const CircularProgressIndicator()) ,

          );
        }
    );
  }
  Widget buildFavoriteItem(FavoritesData model,context)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [

          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(image: NetworkImage(model.product!.image!),
                fit: BoxFit.cover,

                height: 120,
                width: 120,

              ),
              if(model.product!.discount!=0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  color: Colors.red,
                  child:const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.product!.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:const TextStyle(fontSize: 14.0,height: 1.3),),
                const Spacer(),
                Row(
                  children: [
                    Text('${model.product!.price!}',

                      style:const TextStyle(fontSize: 12.0,color: defaultColor),),
                    const SizedBox(width: 5,),
                    if(model.product!.discount!=0)
                      Text('${model.product!.oldPrice!}',

                        style:const TextStyle(
                            fontSize: 10.0,
                            color:Colors.grey,
                            decoration:TextDecoration.lineThrough),//خط
                      ),
                    const  Spacer(),
                    IconButton(
                      onPressed:(){
                        ShopCubit.get(context).changeFavorites(model.product!.id!);
                      }
                      , icon:CircleAvatar(
                      backgroundColor:ShopCubit.get(context).favorites[model.product!.id]!?defaultColor :Colors.grey ,

                      radius: 15,
                      child:
                      Icon(Icons.favorite_border,
                        size: 12,
                        color:Colors.white,
                      ),
                    ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
