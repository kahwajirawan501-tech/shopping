
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping/layout/shop_layout.dart';
import 'package:shopping/login/cubit/cubit.dart';
import 'package:shopping/login/cubit/states.dart';
import 'package:shopping/register/shop_login_register.dart';
import 'package:shopping/shared/components/components.dart';
import 'package:shopping/shared/network/local/cache_helper.dart';

import '../shared/components/constant.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
   ShopLoginScreen({Key? key}) : super(key: key);
var emailController =TextEditingController();
var passwordController =TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>ShopLoginCubit(),

      child: BlocConsumer<ShopLoginCubit,ShopLoginState>(
        listener:(context,state){
          if(state is ShopLoginSuccessState)//نجاح او فشل التسجيل
            {
              if(state.loginModel.status){
                print(state.loginModel.message);
                //showToast(text:state.loginModel.message ,state: ToastStates.SUCCESS);//انا عند نجاح العملية مالح اظهر توست لا لح انتقل ع صفحة جديدة
                CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).
                then((value){
                  token=state.loginModel.data!.token;

                  navigateAndFinish(widget:const ShopLayout() ,context: context);
                });
              }
              else{
                print(state.loginModel.message);
                showToast(text:state.loginModel.message ,state: ToastStates.EROOR);

              }
            }
        } ,
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
                        Text('Login ',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),),
                        Text('Login now to browser our hot offers',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),),
                        const  SizedBox(
                          height: 30.0,

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
                          suffix:ShopLoginCubit.get(context).suffix,
                          isPassword: ShopLoginCubit.get(context).isPasswordShown,
                          onSubmit:(value){

                            if(formKey.currentState!.validate()){

   ShopLoginCubit.get(context).userLogin(email:emailController.text, password:passwordController.text);

                            }
                          },
                          suffixPressed:(){//eyes
                            ShopLoginCubit.get(context).changePasswordVisibility();
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
                        ConditionalBuilder(

                          condition:state is! ShopLoginLoadingState ,
                          builder:(context)=>defaultButton(function:(){
                           if(formKey.currentState!.validate()){

            ShopLoginCubit.get(context).userLogin(email:emailController.text, password:passwordController.text);

                          }

                          }, text: 'login'),
                          fallback:(context)=>const Center(child:  CircularProgressIndicator()) ,


                        ),
                        Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children:  [
                            const Text('don\'t  have account ? '),
                            defaultTextButton(
                                function:(){
                                  navigateAndFinish(context: context,widget:  ShopRegisterScreen(),);//اذا ما بدي اقرء الصفحات

                                }, text: 'register'),


                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } ,

      ),
    );
  }
}
