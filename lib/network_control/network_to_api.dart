import 'package:artify/app_background/app_state_provider.dart';
import 'package:artify/network_control/network_object.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const apiKey = "DrnfEhU__6t1Tm_cP7jvKg2cph858pOWYDELjLCWBno";
final apiUrl = 'https://api.unsplash.com';

BaseOptions option = BaseOptions(
  baseUrl: apiUrl,
  headers: {'Authorization': 'Client-ID $apiKey'},
);

List<NetworkObject> images = [];
final dio = Dio(option);

Future SearchData(
  String text,
  int pageNo,
  bool isHome, {
  int perPage = 24,
}) async {
  dio.options.queryParameters = {
    'per_page': perPage,
    'query': text,
    'page': pageNo,
  };
  try {
    Response response = await dio.get((isHome) ? '/photos' : '/search/photos');
    images.clear();
    if (response.statusCode == 200) {
      images =
          (((isHome) ? response.data : response.data['results']) as List)
              .map((json) => NetworkObject.fromJson(json))
              .toList();
      // print(response.data['results']);
      return images;
    } else {
      print("Failed to fetch data, Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
  }
  dio.close();
}

// Future fetchData(String query, int pageNo, {int perPage = 24}) async {
//   dio.options.queryParameters = {
//     'per_page': perPage,
//     'query': query,
//     'page': pageNo,
//   };
//   try {
//     Response response = await dio.get('/photos');

//     if (response.statusCode == 200) {
//       images =
//           (response.data as List)
//               .map((json) => NetworkObject.fromJson(json))
//               .toList();
//       return images;
//     } else {
//       print("Failed to fetch data, Status code: ${response.statusCode}");
//     }
//   } catch (e) {
//     print("Error: $e");
//   }
// }

List<String> currentCollectionIds = [];

Future fetchImageCollectionId(String text) async {
  dio.options.queryParameters = {'query': text}; //'per_page': 10
  currentCollectionIds.clear();
  try {
    Response response = await dio.get('/search/collections');

    if (response.statusCode == 200) {
      for (var item in response.data['results']) {
        currentCollectionIds.add(item['id']);
      }
      // print(currentCollectionIds);
      return currentCollectionIds;
    } else {
      print("Failed to fetch data, Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
  }
}

Future fetchImageByCollectionId(String id) async {
  dio.options.queryParameters = {'per_page': 15}; //'per_page': 10
  try {
    Response response = await dio.get('/collections/$id/photos');
    if (response.statusCode == 200) {
      images =
          (response.data as List)
              .map((json) => NetworkObject.fromJson(json))
              .toList();
      return images;
    } else {
      print("Failed to fetch data, Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
  }
}
