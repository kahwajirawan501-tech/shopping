import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/cubit/cubit.dart';
import 'package:shopping/layout/shop_layout.dart';
import 'package:shopping/login/cubit/cubit.dart';
import 'package:shopping/login/cubit/states.dart';
import 'package:shopping/register/cubit/cubit.dart';
import 'package:shopping/register/cubit/states.dart';
import 'package:shopping/shared/components/components.dart';
import 'package:shopping/shared/components/constant.dart';
import 'package:shopping/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
   ShopRegisterScreen({Key? key}) : super(key: key);
  var formKey=GlobalKey<FormState>();
   var nameController =TextEditingController();
  var emailController =TextEditingController();
  var passwordController =TextEditingController();
  var phoneController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterState>(
        listener:(context,state){
          if(state is ShopRegisterSuccessState)//نجاح او فشل التسجيل
              {
            if(state.registerModel.status){
              print(state.registerModel.message);
              //showToast(text:state.loginModel.message ,state: ToastStates.SUCCESS);//انا عند نجاح العملية مالح اظهر توست لا لح انتقل ع صفحة جديدة
              CacheHelper.saveData(key: 'token', value: state.registerModel.data!.token).
              then((value){
                token=state.registerModel.data!.token;

                navigateAndFinish(widget:const ShopLayout() ,context: context);
              });
            }
            else{
              print(state.registerModel.message);
              showToast(text:state.registerModel.message ,state: ToastStates.EROOR);

            }
          }
        },
        builder:(context,state){
          return  Scaffold(
            appBar: AppBar(

            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(

                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(

                      crossAxisAlignment:CrossAxisAlignment.start ,
                      children: [
                        Text('Register ',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),),
                        Text('Register now to browser our hot offers',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),),
                        const  SizedBox(
                          height: 30.0,

                        ),
                        defaultFromField(
                          controller:nameController,
                          type: TextInputType.name,
                          label:'UserName' ,
                          prefix:Icons.person ,
                          validator:( value)
                          {
                            if(value.isEmpty)
                            {
                              return 'please enter your name ';
                            }
                            else{
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFromField(
                          controller:emailController,
                          type: TextInputType.emailAddress,
                          label:'Email address' ,
                          prefix:Icons.email_outlined ,
                          validator:( value)
                          {
                            if(value.isEmpty)
                            {
                              return 'please enter your email address';
                            }
                            else{
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFromField(
                          controller:passwordController,
                          type: TextInputType.visiblePassword,
                          label:'Password' ,
                          prefix:Icons.lock_outline,
                          suffix:ShopRegisterCubit.get(context).suffix,
                          isPassword: ShopRegisterCubit.get(context).isPasswordShown,
                          // onSubmit:(value){
                          //
                          //   if(formKey.currentState!.validate()){
                          //
                          //     ShopLoginCubit.get(context).userLogin(email:emailController.text, password:passwordController.text);
                          //
                          //   }
                          // },
                          suffixPressed:(){//eyes
                            ShopRegisterCubit.get(context).changePasswordVisibility();
                          },
                          validator:( value)
                          {
                            if(value.isEmpty)
                            {
                              return 'password is too short';
                            }
                            else{
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFromField(
                          controller:phoneController,
                          type: TextInputType.phone,
                          label:'phone' ,
                          prefix:Icons.phone ,
                          validator:( value)
                          {
                            if(value.isEmpty)
                            {
                              return 'please enter your phone';
                            }
                            else{
                              return null;
                            }
                          },
                        ),

                        const SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(

                          condition:state is !ShopRegisterLoadingState ,
                          builder:(context)=>defaultButton(function:(){
                            if(formKey.currentState!.validate()){

                              ShopRegisterCubit.get(context).userRegister(
                                  email: emailController.text, password: passwordController.text,
                                  name:nameController.text, phone: phoneController.text);


                            }

                          }, text: 'Register'),
                          fallback:(context)=>const Center(child:  CircularProgressIndicator()) ,


                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
