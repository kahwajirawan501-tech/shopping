import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo({context,widget})=>Navigator.push(//الصفحات لسا معي اذا عملت باك
    context
    , MaterialPageRoute(
  builder: (context)=>widget,
));
void navigateAndFinish({context,widget})=>Navigator.pushAndRemoveUntil(//هي ماعد ارجع ع صفحة متل تسجيل الدخول
    context
    , MaterialPageRoute(
  builder: (context)=>widget,
),
    ( Route<dynamic>route)=>false,//هاد الصفحة يلي فاتت بدي ياها ولا لا
);
Widget defaultFromField({
  required TextEditingController  controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
  ValueChanged<String>? onChanged,
  Function()?suffixPressed,
  required FormFieldValidator? validator,
  ValueChanged<String>?onSubmit,
  GestureTapCallback? onTap,
   IconData? suffix ,
  bool isPassword=false,
})=>Padding(
  padding: const EdgeInsets.all(4.0),
    child:   TextFormField(
    validator:validator ,
    controller: controller,
    keyboardType:type ,
  onFieldSubmitted:onSubmit ,
    onTap: onTap,
    obscureText: isPassword,
    decoration:InputDecoration(
     labelText: label,
      border:const OutlineInputBorder(),
      prefixIcon:Icon(
        prefix,
      ),
     suffixIcon: IconButton(icon: Icon(suffix), onPressed:suffixPressed)


      // suffixIcon: Icon(
      //   suffix,
      // ),
    ),
    onChanged: onChanged,
  ),
);
    Widget defaultButton({
      double width=double.infinity,
      bool isUpperCase=true,
  required Function()?function,
  required String text,
      double radius=3.0,
})=>Container(
      height: 50.0,

  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: Colors.blueAccent,
  ),

  child:   Center(

    child:   TextButton(

        onPressed:function,
        child: Text(text.toUpperCase()
          ,style:const TextStyle(
          color: Colors.white,

        ),

    )),
  ),
);
      Widget defaultTextButton({
        required Function()?function,
        required String text,})=>TextButton(onPressed:function, child:Text(text.toUpperCase()));
      //////////////////////////////////////
      void showToast({
  required String text,
  required ToastStates state,
})=>Fluttertoast.showToast(
          msg: text,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,//ظهور
          timeInSecForIosWeb: 5,
          backgroundColor: chooseToastColor(state),
          textColor: Colors.white,
          fontSize: 16.0
      );
      enum ToastStates{
        SUCCESS,EROOR,WARNING
      }
      Color chooseToastColor(ToastStates state)
      {  Color color;
        switch(state){
          case ToastStates.SUCCESS:
            color= Colors.green;

            break;
          case ToastStates.EROOR:
            color=  Colors.red;
            break;
          case ToastStates.WARNING:
            color=  Colors.amber;
            break;

        }
        return color;

      }
        Widget MyLine()=>Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(width:double.infinity ,height: 1,color: Colors.grey[300],),
        );