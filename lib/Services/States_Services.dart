// import 'dart:convert';

// import 'package:covid_tracker/Services/Utilities/App_url.dart';
// import 'package:http/http.dart' as http;

// import '../Model/World_States_Model.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'Utilities/App_url.dart';

// class StatesServices {
//   Future<WorldStatesModel> fetchWorldStatesRecords() async {
//     final responce = await http.get(Uri.parse(AppUrl.worldStatesApi));
//     var data = jsonDecode(responce.body);
//     print(responce.statusCode);
//     if (responce.statusCode == 200) {
//       return WorldStatesModel.fromJson(data);
//     } else {
//       return WorldStatesModel.fromJson(data);
//     }
//   }

  // Future<List<dynamic>> countriesListApi() async {
  //   var data;
  //   final responce = await http.get(Uri.parse(AppUrl.countriesList));
  //   if (responce.statusCode == 200) {
  //     data = jsonDecode(responce.body);

  //     return data;
  //   } else {
  //     throw Exception("error");
  //   }
  // }
// }
