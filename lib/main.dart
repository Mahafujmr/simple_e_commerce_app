import 'package:api_project_one/screens/home_screens.dart';
import 'package:api_project_one/screens/product_add_carts_screens.dart';
import 'package:api_project_one/screens/product_details_screens.dart';
import 'package:api_project_one/utils/app_route_helper.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp ({super.key});
  @override
  Widget build (BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     // initialRoute:  RouteHelper.homescreens,
      //routes: RouteHelper.getRoute(),
     home: HomeScreens(),
    );
  }
}