import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/cubit/cubit.dart';
import 'package:shopping/cubit/states.dart';
import 'package:shopping/shared/components/components.dart';
import 'package:shopping/shared/components/constant.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);
   var fromKey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state)=>{
     // if (state is ShopSuccessUserDateState){//هون ما حتتعبا الداتا لانو الستيت سريع
     //   nameController.text=state.loginModel.data!.name,
    ////    emailController.text=state.loginModel.data!.email,
     //   phoneController.text=state.loginModel.data!.phone,
    //  }

      },
      builder: (context,state){
      // var model=ShopCubit.get(context).userModel!;//هون الايرور
      //   nameController.text=model.data!.name;
      //   emailController.text=model.data!.email;
      //   phoneController.text=model.data!.phone;

        return  ConditionalBuilder(//               !=
        condition:ShopCubit.get(context).userModel== null ,
        builder:(context)=>Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: fromKey,
            child: Column(
              children: [
                if(state is ShopLoadingUpdateUserState)
                LinearProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                defaultFromField(
                  controller: nameController,
                  type: TextInputType.name,
                  label: 'Name',
                  prefix:Icons.person,
                  validator:( value){
                    if(value.isEmpty)
                    {
                      return 'name must not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFromField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  label: 'email',
                  prefix:Icons.email,
                  validator:( value){
                    if(value.isEmpty)
                    {
                      return 'email must not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFromField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  label: 'phone',
                  prefix:Icons.phone,
                  validator:( value){
                    if(value.isEmpty)
                    {
                      return 'phone must not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                 defaultButton(function:(){
                   signOut(context);
                 }, text: 'Logout'),
                SizedBox(
                  height: 25.0,
                ),
                defaultButton(function:(){
                  if(fromKey.currentState!.validate())
                    {
                      ShopCubit.get(context).updateUserData(name:nameController.text,
                          email: emailController.text, phone: phoneController.text);

                    }
                   }
                , text: 'update'),

              ],
            ),
          ),
        ) ,
        fallback:(context)=>const Center(child: CircularProgressIndicator()) ,

      );
      },

    );
  }
}
