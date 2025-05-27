// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// Future<void> addCart() async {
//   final url = Uri.parse('https://fakestoreapi.com/carts');
//
//   final response = await http.post(
//     url,
//     headers: {"Content-Type": "application/json"},
//     body: jsonEncode({
//       "userId": 5,
//       "id": 0,
//       "products": [
//         {"price": 1, "quantity": 2},
//         {"title": "title", "quantity": 1}
//       ]
//     }),
//   );
//
//   if (response.statusCode == 200 || response.statusCode == 201) {
//     print("Cart added successfully: ${response.body}");
//   } else {
//     print("Failed to add cart: ${response.body}");
//   }
// }
