
import 'package:flutter/material.dart';
import 'package:shopping/login/shop_login_screen.dart';
import 'package:shopping/shared/components/components.dart';
import 'package:shopping/shared/network/local/cache_helper.dart';
import 'package:shopping/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.title,
    required this.image,
    required this.body,

  });
}

class OnBoardingScreen extends StatefulWidget {

   const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  List<BoardingModel>boarding=[
    BoardingModel(title: 'On Board 1 Title', image:'images/shopping2.jpg', body: 'On Board 1 Body'),
    BoardingModel(title: 'On Board 2 Title', image:'images/shoping1.jpg', body: 'On Board 2 Body'),
    BoardingModel(title: 'On Board 3 Title', image:'images/shopp3.jpg', body: 'On Board 3 Body'),
  ];

  var boardController=PageController();
  bool isLast=false;
  void submit(){//
    CacheHelper.saveData(key: 'onBoarding', value:true).then((value){
      if(value)
        {
          navigateAndFinish(context: context,widget: ShopLoginScreen(),);

        }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
         defaultTextButton(
             function:(){

               submit();//اذا ما بدي اقرء الصفحات

             }, text: 'skip'),
        ],
      ),
    body:Container(
      color: Colors.white,
      child: Padding(

        padding: const EdgeInsets.all(30.0),

        child: Column(

          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                  onPageChanged: (int index)=>{
                  if(index==boarding.length-1)
                    {
                      setState((){
                        isLast=true;
                      })
                    }
                  else{
                    setState((){
                      isLast=false;
                    })

              }
                  },
                  physics: const BouncingScrollPhysics(),//من شان ما يعطي لون انا وعم زيح
                  itemBuilder:(context,index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),


            Row(
              children: [
               SmoothPageIndicator(//هاد الشكل تبع الدوءر
                   controller:boardController,
                   effect:const ExpandingDotsEffect(
                     dotColor: Colors.grey,//لو ن ال دواىر يلي مو مضغوط عليهم
                     dotHeight: 10,
                     expansionFactor: 4,//مسافات يلي بيناتهم انا وعم اتنقل بينهم بيكبر
                     activeDotColor: defaultColor,//لون المحدد
                     dotWidth: 10,
                     spacing: 5,
                   ) ,//الديزاين تبعو
                   count: boarding.length),
                 Spacer(),
                FloatingActionButton(
                  onPressed:(){
                    if(isLast){
                      submit();
                    }else{
                      boardController.nextPage(duration: const Duration(//من شان اقلب البيج
                        milliseconds: 750,
                      ), curve: Curves.easeIn,);

                    }

                  },
                  child:const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),

          ],
        ),
      ),
    ) ,
    );

  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
            image:AssetImage(model.image),fit: BoxFit.cover,),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(model.title,style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),),
      SizedBox(
        height: 15.0,
      ),
      Text(model.body,style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),),


    ],
  );
}
