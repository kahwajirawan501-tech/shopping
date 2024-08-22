import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/cubit/cubit.dart';
import 'package:shopping/cubit/states.dart';
import 'package:shopping/models/categories_model.dart';
import 'package:shopping/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,index){

      } ,
      builder:(context,index){
    return ListView.separated(
    itemBuilder:(context,index)=>buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
    separatorBuilder:(context,index)=>MyLine(),
    itemCount:ShopCubit.get(context).categoriesModel!.data!.data.length,

    );

    }
    );
  }
  Widget buildCatItem(DataModel dataModel)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage(dataModel.image!),width: 80,height: 80,fit: BoxFit.cover,),
        SizedBox(width: 20,),
        Text(dataModel.name!,style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
        Spacer(),
        Icon(Icons.arrow_forward_ios),


      ],
    ),
  );
}
