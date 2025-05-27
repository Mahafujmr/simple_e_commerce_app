import 'package:api_project_one/screens/cart_item_screens.dart';
import 'package:api_project_one/utils/app_colors.dart';
import 'package:api_project_one/utils/app_images.dart';
import 'package:flutter/material.dart';
class ProductDetailsScreens extends StatefulWidget {
  final String title;
  final String price;
  final String description;
  final String imageLink;
  final String rate;
  final String count;
  const ProductDetailsScreens({super.key,
    required this.title,
    required this.price,
    required this.description,
    required this.imageLink,
    required this.rate,
    required this.count,

  });

  @override
  State<ProductDetailsScreens> createState() => _ProductDetailsScreensState();
}

 List<String> productImage =[
   'assets/images/product1.png',
   'assets/images/product2.png',
   'assets/images/product3.png',
   'assets/images/product4.png',
   'assets/images/product5.png',
   'assets/images/product6.png',
   'assets/images/product7.png',
   'assets/images/product8.png',
 ];
int selectIndex =0;

class _ProductDetailsScreensState extends State<ProductDetailsScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Product Details',style: TextStyle(
          color: AppColor.loveColor
        ),),
        backgroundColor: AppColor.cardColor,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Image.asset(AppImage.addCard,height: 30,color: Colors.white,),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.imageLink,
            height: 250,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,style: TextStyle(
                  color: Colors.black,fontSize: 20,fontWeight: FontWeight.w800,
                ),maxLines: 1,softWrap: true,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,),
                SizedBox(height:5,),
                Row(
                  spacing: 3,
                  children: [
                    Image.asset(AppImage.star,height: 20,),
                    Image.asset(AppImage.star,height: 20,),
                    Image.asset(AppImage.star,height: 20,),
                    Image.asset(AppImage.star,height: 20,),
                    Image.asset(AppImage.starOne,height: 20,),
                    SizedBox(width: 6,),
                    Text(widget.rate),
                    Text(':'),
                    Text(widget.count),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('\$${widget.price}',style: TextStyle(
                        color: Colors.black,fontSize: 18,fontWeight: FontWeight.w800
                    ),),
                    SizedBox(width: 10,),
                    Container(
                      width: 60,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(width: 10,),
                   Container(
                     padding: EdgeInsets.all(8),
                     width: 40,
                     height: 30,
                     decoration: BoxDecoration(
                       color: Colors.red[100],
                       borderRadius: BorderRadius.circular(16),
                     ),
                     child: Image.asset(AppImage.aDote,height: 10,),
                   ),
                    SizedBox(width: 7,),
                    Text('3',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),),
                    SizedBox(width: 7,),
                    Container(
                      padding: EdgeInsets.all(8),
                      width: 40,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.asset(AppImage.mmDote,height: 10,),
                    ),

                  ],
                ),
                SizedBox(height: 15,),
                Text(widget.description,style: TextStyle(
                  color: Colors.black54,fontSize: 15,
                ),maxLines: 3,softWrap: true,overflow: TextOverflow.ellipsis,),
                SizedBox(height: 15,),

                Text('Similar Product List:',style: TextStyle(
                  color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700,
                ),),
                SizedBox(height: 7,),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productImage.length,
                    itemBuilder: (context, index) {
                      bool isSelect =index ==selectIndex;
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            selectIndex =index;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(10),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelect ? Colors.red:Colors.white,
                              width: 1,
                            )
                          ),
                          child: Image.asset(
                            productImage[index],
                          ),
                        ),
                      );

                  },),
                )
              ],
            ),
          ),

          //SizedBox(height: 80,),
          Spacer(),
          Stack(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(cartId: 1),));
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 70),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color:AppColor.cardColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    spacing: 3,
                    children: [
                      Image.asset(AppImage.addCard,color: Colors.white,height: 25,),
                      Text("Add To Card",style: TextStyle(
                        color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700,
                      ),)
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  width: 120,
                  height: 60,
                  decoration: BoxDecoration(
                    color:AppColor.loveColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Image.asset(AppImage.heartBlack,color: Colors.white,),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
