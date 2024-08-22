import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/cubit/cubit.dart';
import 'package:shopping/cubit/states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopping/models/categories_model.dart';
import 'package:shopping/models/home_models.dart';
import 'package:shopping/shared/components/components.dart';
import 'package:shopping/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<ShopCubit, ShopStates>(
        listener: (context,state){
          if(state is ShopSuccessChangeFavoritesDateState ){
             if(!state.model.status!){
               showToast(text:state.model.message!, state:ToastStates.EROOR);
             }
          }
        },
        builder: (context,index){
          return ConditionalBuilder(
              condition:ShopCubit.get(context).homeModel!=null&&ShopCubit.get(context).categoriesModel!=null,
              builder:(context)=> productsBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel!,context),
              fallback:(context)=> const Center(child: CircularProgressIndicator()));
        },

    );
  }
  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel,context)=>SingleChildScrollView(
    physics:const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         CarouselSlider(
             items:model.data!.banners!.
             map((e) =>  Image(image: NetworkImage(e.image!),width: double.infinity,fit: BoxFit.cover,),)
                 .toList() ,
             options: CarouselOptions(
               height: 250.0,
               initialPage: 0,//first image
               viewportFraction: 1.0,
               enableInfiniteScroll: true,//contuse around
               reverse: false,// ما بقلب
               autoPlay: true,
               autoPlayInterval:const Duration(seconds: 3,) ,// ادش عم يدور
               autoPlayAnimationDuration:const Duration(seconds: 1) ,
               autoPlayCurve: Curves.fastOutSlowIn,
               scrollDirection: Axis.horizontal,
             ),

         ),
       const SizedBox(height: 10.0,),
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [

             const Text('Categouries',style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),),
             const SizedBox(height: 20.0,),
              Container(
                height: 100,
                child: ListView.separated(
                  physics:const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder:(context,index)=>buildCategoryItem(categoriesModel.data!.data[index]),
                    separatorBuilder:(context,index)=>const SizedBox(width: 10.0,) ,
                    itemCount:categoriesModel.data!.data.length),
              ),
             const SizedBox(height: 20.0,),
              const  Text('New Products',style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),),
           ],
         ),
       ),
        const SizedBox(height: 10.0,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 1.0,//فوق وتحت
            crossAxisSpacing: 1.0,//يمين وشمال
            childAspectRatio: 1/1.58,//طول ب العرض//تبع الكريد
            children:List.generate(
              model.data!.products.length, (index) =>buildGridProduct(model.data!.products[index],context), ),


          ),
        ),

      ],
    ),
  );
  Widget buildGridProduct(ProductModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
         alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.image!),
              width: double.infinity,
              height: 200.0,

            ),
            if(model.discount!=0)
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
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:const TextStyle(fontSize: 14.0,height: 1.3),),
              Row(
                children: [
                  Text('${model.price!}',

                    style:const TextStyle(fontSize: 12.0,color: defaultColor),),
                  const SizedBox(width: 5,),
                  if(model.discount!=0)
                  Text('${model.oldPrice!}',

                    style:const TextStyle(
                        fontSize: 10.0,
                        color:Colors.grey,
                        decoration:TextDecoration.lineThrough),//خط
                  ),
                const  Spacer(),
                  IconButton(
                      onPressed:(){
                         ShopCubit.get(context).changeFavorites(model.id!);
                      }
                      , icon:CircleAvatar(
                     backgroundColor:ShopCubit.get(context).favorites[model.id]!?defaultColor :Colors.grey ,

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
  );
  Widget buildCategoryItem(DataModel dataModel)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(image: NetworkImage(dataModel.image!),
        width:100 ,
        height:100 ,
        fit: BoxFit.cover,
      ),
      Container(
          color: Colors.black.withOpacity(.8),
          width: 100,
          child: Text(dataModel.name!,style: TextStyle(
            color: Colors.white,
          ),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,)),

    ],
  );
}
