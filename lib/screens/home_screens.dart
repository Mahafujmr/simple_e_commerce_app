import 'dart:convert';
import 'package:api_project_one/screens/product_details_screens.dart';
import 'package:api_project_one/utils/app_colors.dart';
import 'package:api_project_one/utils/app_images.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class HomeScreens extends StatefulWidget {

  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _ProductStoreScreensState();
}


class _ProductStoreScreensState extends State<HomeScreens> {
  @override
  void initState() {
    super.initState();
    getProduct();

  }
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List _selectedIndexs=[];
  List product=[

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: <Widget>[
          Image.asset(AppImage.home),
          Image.asset(AppImage.search),
          Image.asset(AppImage.cart),
          Icon(Icons.perm_identity, size: 30),
          Icon(Icons.settings, size: 30),
        ],
        height: 60,
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Product Screens',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: Icon(Icons.arrow_back),
        actions: [
          Icon(Icons.shopping_cart,color: Colors.black,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.notifications,color: Colors.black,),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // text field
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  focusColor: Colors.redAccent.shade200,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.white
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: Colors.white
                    ),
                  ),
                  prefixIcon: Image.asset(AppImage.search,height: 20,),
                  hintText: 'What are you looking for..',
                  hintStyle: TextStyle(fontSize: 15,color: Colors.black87)
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColor.casualColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text('CASUAL',style: TextStyle(fontWeight: FontWeight.w700),),
                        Image.asset(AppImage.causal,),
                      ],),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColor.partyColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('PARTY',style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),),
                          Image.asset(AppImage.party,),
                        ],),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColor.formalColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('FORMAL',style: TextStyle(fontWeight: FontWeight.w700),),
                          Image.asset(AppImage.formal,),
                        ],),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColor.casualColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('CASUAL',style: TextStyle(fontWeight: FontWeight.w700),),
                          Image.asset(AppImage.causal,),
                        ],),
                    ),
                  ],
                ),
              ),
            ),
            if (isLoading) Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(child: CircularProgressIndicator()),
            ) else GridView.builder(
              itemCount: 20,
              padding: EdgeInsets.all(10),
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 2/3,
              ),
              itemBuilder: (context, index) {
                final singleProduct = productList[index];
                return GestureDetector(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreens(

                        title:singleProduct['title'],
                        price :singleProduct['price'].toString(),
                        description :singleProduct['description'],
                        imageLink :singleProduct['image'],
                      rate :singleProduct ['rating']['rate'].toString(),
                      count :singleProduct['rating']['count'].toString(),

                    ),));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 220,
                                height: 450,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColor.boxColor,
                                        offset: Offset(1, 1),
                                        blurRadius: 2,
                                        spreadRadius: 3,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child:Image.network("${singleProduct["image"]}",height: 150,width: 140,),

                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 4,),
                        Text("${singleProduct["title"]}",style: TextStyle(
                            fontSize: 15,color: Colors.black,fontWeight: FontWeight.w800
                        ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 3),
                        Text("Price: \$${singleProduct["price"]}",
                          style: TextStyle(color: Colors.green.shade800,fontWeight:FontWeight.w700),
                        ),
                        SizedBox(height: 3),

                        Row(
                            children: [
                              Icon(Icons.star_rate,size: 15,color: Colors.yellow.shade800,),
                              SizedBox(width: 3),
                              Text("${singleProduct["rating"]["rate"]}",
                                style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.blueAccent),
                              ),
                              SizedBox(width: 3,),
                              Text("${singleProduct["rating"]["count"]}",
                                style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.blueAccent),
                              ),
                              Spacer(),

                            ]
                        ),

                      ],
                    ),
                  ),
                );
              },
            )

          ],
        ),
      )

    );

  }
  dynamic productList =[];
  bool isLoading =false;
  void getProduct() async {
    setState(() {
      isLoading =true;
    });
    Uri productUrl =Uri.parse("https://fakestoreapi.com/products");
    final responseApi = await http.get(productUrl);
    setState(() {
      isLoading=false;
    });
    print(productList);
    setState(() {
      productList =jsonDecode(responseApi.body);
    });
  }
}
