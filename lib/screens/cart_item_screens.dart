import 'package:api_project_one/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'home_screens.dart';

class CartScreen extends StatefulWidget {
  final int cartId;

  const CartScreen({super.key, required this.cartId});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<String>paymentLogo =[
    AppImage.masterCard,
    AppImage.visaCard,
    AppImage.bkashLogo,
    AppImage.nagadLogo,
    AppImage.paypalLogo,
    AppImage.flipcart,
  ];
  int selected =0;



  List<Map<String, dynamic>> cartItems = [
    {"price": 1, "quantity": 2},
    {"title": "title", "quantity": 1},
    {"title": "title", "quantity": 1},
    {"product": "product", "quantity": "quantity"}
  ];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCart(widget.cartId);
  }

  // Fetch cart data
  Future<void> fetchCart(int cartId) async {
    final url = Uri.parse('https://fakestoreapi.com/carts/$cartId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final cartData = jsonDecode(response.body);
      List<dynamic> products = cartData['products'];

      // Fetch product details for each product
      await fetchProductDetails(products);
    } else {
      print("Failed to fetch cart: ${response.body}");
    }
  }

  // Fetch product details using product ID
  Future<void> fetchProductDetails(List<dynamic> products) async {
    List<Map<String, dynamic>> items = [];

    for (var product in products) {
      final productId = product['productId'];
      final productUrl = Uri.parse('https://fakestoreapi.com/products/$productId');

      final productResponse = await http.get(productUrl);

      if (productResponse.statusCode == 200) {
        final productData = jsonDecode(productResponse.body);

        items.add({
          "title": productData['title'],
          "price": productData['price'],
          "image": productData['image'],
          "quantity": product['quantity']
        });
      }
    }

    setState(() {
      cartItems = items;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Cart Items',style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),),centerTitle: true,
        backgroundColor:  Colors.blue[900],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(Icons.share,color: Colors.white,),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Container(
                  width: double.infinity,
                  height: 90,
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                  decoration: BoxDecoration(
                      color: Color(0xfff8f2fb),
                      borderRadius: BorderRadius.circular(20)
                  ),

                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.network(item['image'], width: 50, height: 50),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(item['title'], maxLines: 1, overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Image.asset(AppImage.delete,height: 19,)
                                ],
                              ),
                              Text('Price: \$${item['price']} '),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text('Quantity: ${item['quantity']}'),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Container(
                                          color: Colors.red[50],
                                          child: Icon(Icons.remove),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                              "1"
                                          ),
                                        ),
                                        Container(
                                          color: Colors.red[50],
                                          child: Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            /// subtotal price
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("SubTotal"),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("\$ 800.90"),
                          Text(
                            "Subtotal does not include shipping",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                        ],

                      ),

                    ],
                  )
                ],
              ),
            ),
            /// check out button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16,horizontal: 32),
                        backgroundColor: Colors.black,
                        elevation: 1,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.red),
                        )

                      ),
                        onPressed: (){},
                        child: Text("Check Out",style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text("Payment Method:",style: TextStyle(
                fontSize: 15,fontWeight: FontWeight.w700
              ),),
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                itemCount: paymentLogo.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  bool isSelected =index == selected;
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      selected =index;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 60,
                    height: 60,
                   decoration: BoxDecoration(
                     color: isSelected?Colors.black:Colors.white,
                     borderRadius: BorderRadius.circular(30),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.red.withOpacity(0.2),
                         offset: Offset(1, 1),
                         blurRadius: 5,
                       )
                     ]
                   ),
                    child: Image.asset(paymentLogo[index]),
                  ),
                );
              },),
            ),
           // SizedBox(height: 70,),
            Container(
              margin: EdgeInsets.all(17),
              width: double.infinity,
              alignment: Alignment.center,
              height: 55,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(20),
               border: Border.all(
                 color: Colors.black,
               ),
               boxShadow: [
                 BoxShadow(
                   offset: Offset(0, 1),
                   blurRadius: 5,
                   color: Colors.black.withOpacity(0.3),
                 ),
               ],
             ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Check Out With'),
                  Image.asset(AppImage.bkashLogo,height: 30,),
                  RichText(
                      text: TextSpan(
                        text: "b",
                        style: TextStyle(
                          color: Colors.red[800],
                          fontSize: 18,fontWeight: FontWeight.w700,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Kash",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )
                        ]
                      )
                  ),
                ],
              ),
            ),
           // SizedBox(height: 10,),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreens(),));
                },
                child: Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Continue Shopping",style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),),
                      Icon(Icons.arrow_right,color: Colors.white,)
                    ],
                  ),
                ),
              ),
            )

          ],
        ),
      )
    );
  }
}




