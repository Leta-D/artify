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

Future fetchData(String query, int page) async {
  dio.options.queryParameters = {'per_page': 18, 'query': query};
  try {
    Response response = await dio.get('/photos');

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

Future<NetworkObject?> fetchImageById(String id) async {
  // final appProvide = Provider.of<AppStateProvider>(context);

  // dio.options.queryParameters = {'per_page': 18, 'query': query};
  try {
    Response response = await dio.get('/photos/$id');

    if (response.statusCode == 200) {
      return NetworkObject.fromJson(response.data);
    } else {
      print("Failed to fetch data, Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
  }
}
