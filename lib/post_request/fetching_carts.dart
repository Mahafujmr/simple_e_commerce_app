// import 'dart:convert';
// import 'package:http/http.dart'as http;
// Future<void> fetchCart() async {
//   final url = Uri.parse('https://fakestoreapi.com/carts');
//
//   final response = await http.get(url);
//
//   if (response.statusCode == 200) {
//     final cartData = jsonDecode(response.body);
//     print("Cart Details: $cartData");
//   } else {
//     print("Failed to fetch cart: ${response.body}");
//   }
// }
